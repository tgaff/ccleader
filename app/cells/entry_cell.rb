class EntryCell < Cell::Rails
  def show(args)
    @entry = args[:entry]
    @name = @entry[:member]
    @rank = @entry[:rank]
    @score = @entry[:score]
    @board = args[:board]
    render
  end

  def delete_form(args)
    @entry = args[:entry]
    @board = args[:board]
    render
  end
end
