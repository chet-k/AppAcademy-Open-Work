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

        QuestionFollow.new(follow_data.first)
    end

    def self.followers_for_question_id(question_id)
        users_data = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
            SELECT
                *
            FROM
                users 
            JOIN
                question_follows
            ON
                users.id = question_follows.user_id
            WHERE
                question_follows.question_id = :question_id
        SQL

        users_data.map {|datum| User.new(datum)}
    end

    def self.followed_questions_for_user_id(user_id)
        questions_data = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
            SELECT
                *
            FROM
                questions
            JOIN
                question_follows
            ON
                questions.id = question_follows.question_id
            WHERE
                question_follows.user_id = :user_id            
        SQL

        questions_data.map {|datum| Question.new(datum)}
    end

    def initialize(options)
        id = options['id']
        user_id = options['user_id']
        question_id = options['question_id']
    end
end