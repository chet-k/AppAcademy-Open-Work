# NAIVE SOLUTION
# for each element (N), iterate through entire window (W)
# by slicing the array O(N)
# O(N * W) time 
# O(W) space
def windowed_max_range(arr, window_size)
    current_max_range = 0 #start at minimum possible
    (0...arr.length).each do |i1|
        i2 = i1 + window_size
        window_range = arr[i1...i2].max - arr[i1...i2].min
        current_max_range = window_range if window_range > current_max_range
    end
    current_max_range
end

#tests
# puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8