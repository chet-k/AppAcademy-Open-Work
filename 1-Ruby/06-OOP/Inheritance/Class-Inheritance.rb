require "byebug"


class Employee
    attr_accessor :name, :title, :salary, :boss
    def initialize(name, title, salary, boss = nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end

    def bonus(multiplier)
        @salary * multiplier
    end

    def inspect
        boss = @boss ? @boss.name : nil
        {"name" => @name,
        "title" => @title,
        "salary" => @salary,
        "boss" => boss}.to_s
    end
end

class Manager < Employee
    attr_accessor :subordinates
    def initialize(name, title, salary, boss = nil)
        super(name, title, salary, boss)
        @subordinates = []
    end

    def bonus(multiplier)
        amount = 0
        subordinates.each do |employee| 
            amount += employee.salary
            amount += employee.bonus(1) if employee.is_a?(Manager)
        end
        amount * multiplier
    end

    def add_subordinates(*employees)
        employees.each do |e|
            e.boss = self
            @subordinates << e
        end
    end

    def inspect
        boss = @boss ? @boss.name : nil
        subs = []
        @subordinates.each {|e| subs << e.name}
        {"name" => @name,
        "title" => @title,
        "salary" => @salary,
        "boss" => boss,
        "subordinates" => subs}.to_s
    end
end

if __FILE__ == $PROGRAM_NAME
    david = Employee.new("David","TA",10000)
    shawna = Employee.new("Shawna","TA",12000)
    darren = Manager.new("Darren","TA Manager",78000)
    darren.add_subordinates(david, shawna)
    ned = Manager.new("Ned", "Founder", 1000000)
    ned.add_subordinates(darren)

    p ned
    p darren
    p shawna
    p david

    puts "Ned's bonus at multiplier 5: #{ned.bonus(5)}"
    puts "Darren's bonus at multiplier 4: #{darren.bonus(4)}"
    puts "David's bonus at multiplier 3: #{david.bonus(3)}"
end