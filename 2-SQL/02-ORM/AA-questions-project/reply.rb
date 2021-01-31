require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'question.rb'

class Reply
    attr_accessor :id, :question_id, :parent_reply_id, :author_id, :body

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map {|datum| Reply.new(datum)}
    end

    def self.find_by_id(id)
        reply_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        return nil unless reply_data.length > 0

        Reply.new(reply_data.first)
    end

    def self.find_by_user_id(user_id)
        reply_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                author_id = ?
        SQL
        return nil unless reply_data.length > 0

        reply_data.map {|r| Reply.new(r)}
    end

    def self.find_by_question_id(question_id)
        reply_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
                SELECT
                    *
                FROM
                    replies
                WHERE
                    question_id = ?
            SQL
            return nil unless reply_data.length > 0

            reply_data.map {|r| Reply.new(r)}
    end

    def self.find_by_parent_id(parent_reply_id)
        reply_data = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent_reply_id = ?
        SQL
        return nil unless reply_data.length > 0

        reply_data.map {|r| Reply.new(r)}       
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @author_id = options['author_id']
        @body = options['body']
    end

    def author
        User.find_by_id(author_id)
    end

    def question
        Question.find_by_id(question_id)
    end

    def parent_reply
        Reply.find_by_id(parent_reply_id)
    end

    def child_replies #only depth of 1. replies whose parent is @id
        Reply.find_by_parent_id(id)
    end
end