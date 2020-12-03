class Card
    attr_reader :value
    CARD_BACK = "-"
    
    def initialize(value)
        @value = value
        @face_up = false
    end
    
    def face_up?
        @face_up == true
    end

    def face_value
        return @value if @face_up
        CARD_BACK
    end

    def reveal
        if @face_up
            false
        else
            @face_up = true
            true
        end
    end

    def hide
        @face_up = false
        CARD_BACK
    end

    def ==(other_card)
        @value == other_card.value
    end
end