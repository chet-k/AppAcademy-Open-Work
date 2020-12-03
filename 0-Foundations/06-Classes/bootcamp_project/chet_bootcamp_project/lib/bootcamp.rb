class Bootcamp
    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new { |h, k| h[k] = [] }
    end

    def name
        @name
    end
    
    def slogan
        @slogan
    end

    def teachers
        @teachers
    end

    def students
        @students
    end

    def hire(teacher_name)
        @teachers << teacher_name
    end

    def enroll(student_name)
        if @students.length >= @student_capacity
            return false
        else
            @students << student_name
        end
        true
    end

    def enrolled?(student_name)
        @students.include?(student_name)
    end

    def student_to_teacher_ratio
        @students.length/@teachers.length
    end

    def add_grade(student_name, grade)
        if enrolled?(student_name)
            @grades[student_name] << grade
            return true
        end
        false
    end

    def num_grades(student_name)
        @grades[student_name].length
    end

    def average_grade(student_name)
        if enrolled?(student_name) && @grades[student_name].length > 0
            return @grades[student_name].sum / @grades[student_name].length
        end
        nil
    end
end
