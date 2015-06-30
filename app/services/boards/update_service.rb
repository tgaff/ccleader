module Boards
  class UpdateService < Boards::Base
    def execute(entry_params)
      name = entry_params[:name]
      score = entry_params[:score].to_i
      board = entry_params[:board]
      puts "board name = #{board}"
      leaderboard(board).rank_member(name, score)
      member = leaderboard(board).score_and_rank_for(name)
      member[:page] = leaderboard.page_for(name, leaderboard.page_size)
      member
    end
  end
end
