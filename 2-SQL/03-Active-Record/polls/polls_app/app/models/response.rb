class Response < ApplicationRecord
    validates :user_id, :answer_choice_id, presence: true
    validates :not_duplicate_response

    belongs_to :answer_choice,
        class_name: :AnswerChoice,
        foreign_key: :answer_choice_id,
        primary_key: :id
    
    belongs_to :respondent,
        class_name: :User,
        foreign_key: :user_id,
        primary_key: :id
    
    has_one :question,
        through: :answer_choice,
        source: :question

    def sibling_responses
        self
            .question
            .responses
            .where.not(id: self.id)
    end

    def respondent_already_answered?
        self
            .sibling_responses
            .exists?(user_id: respondent.id)
    end

    private
    def not_duplicate_response
        if respondent_already_answered?
            errors[:base] << 'Invalid response - user already answered!'
        end
    end
end