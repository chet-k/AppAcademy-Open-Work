require_relative 'questions_database.rb'
require_relative 'user.rb'

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map {|datum| Question.new(datum)}
    end

    def self.find_by_id(id)
        question_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        return nil unless question_data.length > 0

        Question.new(question_data.first)
    end 

    def self.find_by_title(title)
        question_data = QuestionsDatabase.instance.execute(<<-SQL, title)
            SELECT
                *
            FROM
                questions
            WHERE
                title = ?
        SQL
        return nil unless question_data.length > 0

        Question.new(question_data.first)
    end 

    def self.find_by_author(fname,lname)
        user = User.find_by_name(fname, lname)
        raise "#{fname} #{lname} not found in DB" unless user
        
        question_data = QuestionsDatabase.instance.execute(<<-SQL, user.id)
            SELECT
                * 
            FROM
                questions
            WHERE
                author_id = ?
        SQL
        return nil unless question_data.length > 0

        Question.new(question_data.first)
    end 

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def author
        User.find_by_id(author_id)
    end
end