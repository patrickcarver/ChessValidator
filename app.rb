module PatrickCarver
  module PuzzleNode
    module ChessValidator
      class App
        def initialize
        end

        def run(board:, moves:, output:)
        end
      end
    end
  end
end

app = PatrickCarver::PuzzleNode::ChessValidator::App.new
app.run board: "txt/complex_board.txt", moves: "txt/complex_moves.txt", output: "txt/output.txt"