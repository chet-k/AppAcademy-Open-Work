require_relative '6_minmaxstackqueue.rb'

def windowed_max_range(arr, window_size)
    s = MinMaxStackQueue.new
    window_size.times {|idx| s.enqueue(arr[idx])}
    
    current_max_range = s.max - s.min
    
    (window_size...arr.length).each do |idx|
        s.enqueue(arr[idx])
        s.dequeue
        
        current_max_range = [current_max_range, s.max - s.min].max
    end
    current_max_range
end

puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8