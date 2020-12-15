require "singleton"
require_relative "piece.rb"

class NullPiece < Piece
    include Singleton
    attr_reader :symbol
    def initialize
        @color = nil
        @symbol = " "
    end 

    def empty?
        true
    end

    def moves
        []
    end
end