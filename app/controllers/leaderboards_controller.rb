class LeaderboardsController < ApplicationController
  before_action :query_options

  def show
    lbs = Redis.current.keys
    @lb_entries = lbs.map do |lb|
      { board: lb,
        results: entry_service.execute(query_options, lb)
      }
    end
    respond_to do |format|
      format.html do
        paginate
      end
      format.json do
        render json: @entries
      end
    end
  end

  private

  def paginate
    count = Boards.all_leaderboards.sum { |b| b.total_members }
    pager = Kaminari.paginate_array(
      @lb_entries,
      total_count: count)

    @page_array = pager.page(@page).per(@limit)
  end

  def entry_service
    Boards::GetAllService.new
  end
end
