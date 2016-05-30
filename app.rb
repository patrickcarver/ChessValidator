require 'pp'

module PatrickCarver
  module PuzzleNode
    module ChessValidator
      class Piece
        attr_reader :player, :name
        attr_accessor :moves

        def initialize(data)
          @moves = []
          @player, @name = data.split ''

          if @player == '-' && @name == '-'
            @player = "NONE"
            @name = "NONE"
          end
        end
      end

      module BoardParser
        def self.run(file_name)
          board = []

          File.open file_name, "r" do |f|
            f.each_line do |line|
              pieces = line.split " "
              pieces.map! { |item| Piece.new item }
              board.push pieces
            end
          end

          board
        end
      end

      class App
        def initialize
        end

        def run(board_file:, moves_file:, output_file:)
          board = BoardParser.run board_file

          board.each_with_index do |row, y|
            row.each_with_index do |piece, x|
              candidate_moves = []

              row_above = y - 1
              row_below = y + 1

              col_left =  x - 1
              col_right = x + 1

              ############################################
              # King
              # TODO: needs to deal with not moving King to a space where he can be put in check.

              if piece.name == 'K'
                row_above.upto row_below do |r|
                  next if r < 0 || r > 8

                  col_left.upto col_right do |c|
                    next if c < 0 || c > 8
                    next if c == x && r == y

                    candidate = board[c][r]

                    if candidate.player != piece.player
                      candidate_moves.push [c, r]
                    end
                  end
                end

                piece.moves.push candidate_moves
              end

              ############################################

              if piece.name == 'P'
                if piece.player == 'b'
                  puts "piece #{piece.player} #{x} #{y}"

                  if row_below < 8
                    space_ahead = board[row_below][x]

                    puts "ahead #{space_ahead.player} #{space_ahead.name} #{x} #{row_below}"

                    if space_ahead.player == "NONE"
                      candidate_moves.push [x, row_below]

                      # on home row
                      if y == 1
                        two_spaces_ahead = board[row_below + 1][x]

                        if two_spaces_ahead.player == "NONE"
                          candidate_moves.push [x, row_below + 1]
                        end
                      end
                    end

                    # add if opposing piece diagonal in front of piece

                    # left
                    if x != 0
                      candidate = board[row_below][col_left]

                      if candidate.player == 'w'
                        candidate_moves.push [col_left, row_below]
                      end
                    end

                    # right
                    if x != 7
                      candidate = board[row_below][col_right]

                      if candidate.player == 'w'
                        candidate_moves.push [col_right, row_below]
                      end
                    end


                  end
                  puts candidate_moves

                end

                if piece.player == 'w'
                  row_above = y + 1


                end
              end

              ############################################
            end
          end
        end
      end
    end
  end
end

app = PatrickCarver::PuzzleNode::ChessValidator::App.new
app.run board_file: "txt/complex_board.txt", moves_file: "txt/complex_moves.txt", output_file: "txt/output.txt"
