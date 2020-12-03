require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        if @salaries.has_key?(title)
            true
        else
            false
        end
    end

    def >(other_startup)
        if self.funding > other_startup.funding
            true
        else
            false
        end
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise "not a valid title"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = @salaries[employee.title]
        if @funding >= salary
            employee.pay(salary)
            @funding -= salary
        else
            raise "not enough funding to pay #{employee.name}"
        end
    end

    def payday
        @employees.each {|employee| pay_employee(employee)}
    end

    def average_salary
        total_salary = 0
        @employees.each {|person| total_salary += @salaries[person.title]}
        1.0 * total_salary / @employees.count
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each do |title, salary|
            @salaries[title] = salary if !@salaries.has_key?(title)
        end
        other_startup.employees.each {|new_employee| @employees << new_employee}
        other_startup.close
    end

end
