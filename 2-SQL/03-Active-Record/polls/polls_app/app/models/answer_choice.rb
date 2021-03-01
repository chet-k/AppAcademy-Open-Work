class AnswerChoice < ApplicationRecord
    belongs_to :question,
        class_name: :Question,
        foreign_key: :question_id,
        primary_key: :id
    
    has_many :responses,
        clsss_name: :Response,
        foreign_key: :answer_choice_id,
        primary_key: :id
end