require 'pp'

module PatrickCarver
  module PuzzleNode
    module ChessValidator
      class Piece
        attr_reader :player, :name

        def initialize(data)
          @player, @name = data.split ''

          if @player == '-' && @name == '-'
            @player = "NONE"
            @name = "NONE"
          end 
        end
      end

      module BoardParser
        def self.run(file_name)
          puts file_name
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
          pp board

        end
      end
    end
  end
end

app = PatrickCarver::PuzzleNode::ChessValidator::App.new
app.run board_file: "txt/complex_board.txt", moves_file: "txt/complex_moves.txt", output_file: "txt/output.txt"