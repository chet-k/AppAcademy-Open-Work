require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'question.rb'

class QuestionFollow
    attr_accessor :id, :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map {|datum| QuestionFollow.new(datum)}
    end

    def self.find_by_id(id)
        follow_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        return nil unless follow_data.length > 0

        QuestionFollow.new(u.first)
    end

    def initialize(options)
        id = options['id']
        user_id = options['user_id']
        question_id = options['question_id']
    end
end