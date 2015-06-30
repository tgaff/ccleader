module Boards
  class DeleteService < Boards::Base
    def execute(options = {})
      return unless member_exists?(options[:name], options[:board])
      leaderboard(options[:board]).remove_member(options[:name])
    end

    private

    def member_exists?(name, board)
      leaderboard(board).check_member?(name)
    end
  end
end
