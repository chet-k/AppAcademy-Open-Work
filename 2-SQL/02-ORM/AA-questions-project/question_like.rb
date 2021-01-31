require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'question.rb'

class QuestionLike
    attr_accessor :id, :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map {|datum| Reply.new(datum)}
    end

    def self.find_by_id(id)
        like_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        return nil unless like_data.length > 0

        Reply.new(like_data.first)
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end
end