require "singleton"
require_relative "piece.rb"

class NullPiece < Piece
    include Singleton
    attr_reader :color, :symbol
    def initialize
        @color = nil
        @symbol = " "
    end 
end