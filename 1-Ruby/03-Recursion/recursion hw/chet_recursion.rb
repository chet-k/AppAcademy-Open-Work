# 1. Read the problem statement to make sure you fully understand the problem 
# 2. Identify the base case(s) 
# 3. Determine the inductive step 
# 4. Write the function 
# 5. Run the provided test cases to verify you have a working solution

def sum_to(n)
    if n <= 0
        nil
    elsif n == 1
        n
    else
        n + sum_to(n-1)
    end
end
# p sum_to(5)  # => returns 15
# p sum_to(1)  # => returns 1
# p sum_to(9)  # => returns 45
# p sum_to(-8)  # => returns nil

def add_numbers(arr)
    if arr.length == 0
        0
    elsif arr.length == 1
        arr[0]
    else
        arr[0] + add_numbers(arr[1..-1])
    end
end
# p add_numbers([1,2,3,4]) # => returns 10
# p add_numbers([3]) # => returns 3
# p add_numbers([-80,34,7]) # => returns -39
# p add_numbers([]) # => returns nil

def gamma_fnc(n)
    # defined Γ(n) = (n-1)!
    if n <= 0
        nil
    elsif n == 1
        1
    else
        (n-1) * gamma_fnc(n-1)
    end
end
# p gamma_fnc(0)  # => returns nil
# p gamma_fnc(1)  # => returns 1
# p gamma_fnc(4)  # => returns 6
# p gamma_fnc(8)  # => returns 5040

def ice_cream_shop(flavors, favorite)
    if flavors.length == 0
        false
    elsif flavors[0] == favorite
        true
    else
        ice_cream_shop(flavors[1..-1], favorite)
    end
end
# p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
# p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
# p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
# p ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
# p ice_cream_shop([], 'honey lavender')  # => returns false

def reverse(s)
    s.length <= 1 ? s : reverse(s[1..-1]) + s[0]
end
# p reverse("house") # => "esuoh"
# p reverse("dog") # => "god"
# p reverse("atom") # => "mota"
# p reverse("q") # => "q"
# p reverse("id") # => "di"
# p reverse("") # => ""