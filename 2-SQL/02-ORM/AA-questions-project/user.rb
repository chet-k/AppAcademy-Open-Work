require_relative 'questions_database.rb'
require_relative 'user.rb'

class User
    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map {|datum| User.new(datum)}
    end

    def self.find_by_id(id)
        q = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        return nil unless q.length > 0

        User.new(q.first)
    end 

    def self.find_by_name(fname, lname)
        q = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND lname = ?
        SQL
        return nil unless q.length > 0

        User.new(q.first)
    end 

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end