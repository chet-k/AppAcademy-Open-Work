require_relative 'card.rb'

class Hand
    attr_reader :cards
    def initialize
        @cards = []
    end
    
    def add_card(new_card)
        raise "hand is already full!" if full?
        raise "input must be Card class" unless new_card.is_a?(Card)
        @cards << new_card

        @cards.sort_by!(&:rank)
    end

    def full?
        @cards.length == 5
    end

    def wins_against?(other_deck)
        raise "can only compare full hands" unless self.full? && other_deck.full?

        case self.category <=> other_deck.category
        when -1
            true  #my hand wins if my category is lower
        when 1
            false #other hand wins if my category is higher
        when 0
            # if hand categories are the same, then the group lengths will 
            # also be the same.
            my_groups, other_groups = self.group_cards_by_kind, other_deck.group_cards_by_kind
            my_groups.each_with_index do |g, i|
                el1 = g[0]
                el2 = other_groups[i][0]
                next if el1 == el2
                return el1 < el2
            end
        end
    end

    def category
        return nil unless self.full?
        
        @cards.sort_by!(&:rank)
        groups = group_cards_by_kind

        if straight? && flush?
            1
        elsif groups[0].length == 4 #4-of-a-kind
            2
        elsif groups[0].length == 3 && groups[1].length == 2 #full-house
            3
        elsif flush?
            4
        elsif straight?
            5
        elsif groups[0].length == 3 #3-of-a-kind
            6
        elsif groups[0].length == 2 && groups[1].length == 2 #2-pair
            7
        elsif groups[0].length == 2 #pair
            8
        elsif groups.length == 5 #high card
            9
        else
            raise "hand ranking logic needs to be fixed."
        end 
    end

    def ==(other_hand)
        other_cards = other_hand.cards
        @cards.each_with_index {|c, i| return false unless c.value == other_cards[i].value}
        true
    end

    def group_cards_by_kind
        @cards.sort_by(&:rank)
        out = [[]]
        
        @cards.each do |c|
            if out[-1].empty? || out[-1][-1] == c.rank
                out[-1] << c.rank
            else
                out << [c.rank]
            end
        end

        out.sort_by{|a| -a.length}
    end

    private

    def flush?
        @cards.all? {|c| c.suit == @cards[0].suit}
    end

    def straight?
        return false unless self.full?
        @cards.sort_by!(&:rank)

        straight_ranking = @cards[0].rank
        @cards.each do |c|
            return false unless c.rank == straight_ranking
            straight_ranking += 1
        end
        true
    end
end