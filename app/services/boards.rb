module Boards
  DEFAULT_BOARD = 'ccleaders'

  def self.default_leaderboard
    Leaderboard.new(
      DEFAULT_BOARD,
      default_options,
      redis_connection: Redis.current
    )
  end

  def self.specific_leaderboard(board)
    Leaderboard.new(
      board,
      default_options,
      redis_connection: Redis.current
    )
  end

  def self.all_leaderboards
    board_names = Redis.current.keys
    board_names.map do |name|
      specific_leaderboard(name)
    end
  end

  def self.default_options
    Leaderboard::DEFAULT_OPTIONS.merge(
      page_size: 10
    )
  end

  class Base
    def leaderboard(board=nil)
      Boards.specific_leaderboard(board) || @leaderboard ||= Boards.default_leaderboard
    end
  end
end
