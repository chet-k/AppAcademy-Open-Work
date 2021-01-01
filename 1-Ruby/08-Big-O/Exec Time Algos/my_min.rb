def my_min_quadratic(list)
    # for each element (n operations), 
    # loops through the entire list (n operations).
    # n * n -> O(n^2) execution time
    list.each { |el1| return el1 if list.all?{|el2| el1 <= el2} }
end

def my_min_linear(list)
    # loops through list only once, making a simple comparison at each element.
    # n * constant -> O(n) execution time
    current_min = list[0]
    list.each { |el| current_min = el if el < current_min }
    current_min
end

example_list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
puts "example list: #{example_list.inspect}"
puts "minimum (quadratic time): #{my_min_quadratic(example_list)}"
puts "minimum (linear time): #{my_min_linear(example_list)}"

