require_relative 'questions_database.rb'
require_relative 'user.rb'

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map {|datum| Question.new(datum)}
    end

    def self.find_by_id(id)
        q = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        return nil unless q.length > 0

        Question.new(q.first)
    end 

    def self.find_by_title(title)
        q = QuestionsDatabase.instance.execute(<<-SQL, title)
            SELECT
                *
            FROM
                questions
            WHERE
                title = ?
        SQL
        return nil unless q.length > 0

        Question.new(q.first)
    end 

    def self.find_by_author(fname,lname)
    end 

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

end