require './Chess.rb'
#
# module SlidingPieces
#   def poss_moves(board)
#     poss_moves = []
#     @deltas.each do |delta|
#       new_pos = add_positions(delta)
#       temp_piece = Piece.new(color,new_pos)
#       poss_moves.concat(single_dir_moves(board, temp_piece, delta))
#     end
#     poss_moves
#   end
#
#   private
#   #REFACTOR REFACTOR REFACTOR
#   def single_dir_moves(board, temp_piece, delta)
#     p temp_piece.curr_pos
#     if board.out_of_bounds?(temp_piece.curr_pos)
#       return []
#     else
#       unless board[temp_piece.curr_pos].nil?
#         if board[temp_piece.curr_pos].color == color
#           return []
#         end
#       end
#     end
#
#     moves = []
#     temp_piece = Piece.new(color,temp_piece.add_positions(delta))
#     moves.concat(single_dir_moves(board, temp_piece, delta))
#     moves.concat([temp_piece.curr_pos])
#     moves
#   end
# end

module SlidingPieces
  def poss_moves(board)
    poss_moves = []
    @deltas.each do |delta|
      poss_moves.concat(single_dir_moves(board, delta))
    end
    poss_moves
  end

  private
  #REFACTOR REFACTOR REFACTOR
  def single_dir_moves(board, delta)
    single_dir_moves = []
    new_pos = add_positions(delta)
    temp_piece = Piece.new(color,new_pos)
    while !board.out_of_bounds?(temp_piece.curr_pos) &&
              board[temp_piece.curr_pos].nil?
      single_dir_moves << temp_piece.curr_pos
      temp_piece = Piece.new(color,temp_piece.add_positions(delta))
    end
    unless board.out_of_bounds?(temp_piece.curr_pos)
      if board[temp_piece.curr_pos].color != color
        single_dir_moves << temp_piece.curr_pos
      end
    end
    single_dir_moves
  end
end

class Queen < Piece
  include SlidingPieces
  attr_reader :display_type

  def initialize(color, initial_pos)
    super(color,initial_pos)
    @display_type = "Q"
    @deltas = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
  end
end


class Rook < Piece
  include SlidingPieces
  attr_reader :display_type

  def initialize(color, initial_pos)
    super(color,initial_pos)
    @display_type = "R"
    @deltas = [[-1,0],[0,-1],[0,1],[1,0]]
  end
end


class Bishop < Piece
  include SlidingPieces
  attr_reader :display_type

  def initialize(color, initial_pos)
    super(color,initial_pos)
    @display_type = "B"
    @deltas = [[-1,1],[1,-1],[1,1],[-1,-1]]
  end
end
