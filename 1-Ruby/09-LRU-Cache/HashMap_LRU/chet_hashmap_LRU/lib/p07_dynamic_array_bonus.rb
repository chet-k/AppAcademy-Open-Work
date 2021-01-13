class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= @count || -i > @count
    i = i < 0 ? @count + i : i

    @store[i]
  end

  def []=(i, val)
    if i < 0
      return nil if -i > @count
      i = @count + i
    else
      push(nil) until @count >= i + 1
    end

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    @count.times {|i| return true if @store[i] == val}
    false
  end

  def push(val)
    @count += 1
    resize! if count > capacity
    
    @store[@count - 1] = val
  end

  def unshift(val)
    return nil if @count == 0

    @count += 1
    resize! if count > capacity

    (1..@count-1).reverse_each { |i| @store[i] = @store[i-1] }
    self[0] = val
  end

  def pop
    return nil if @count == 0
    out = last
    @count -= 1
    out
  end

  def shift
    return nil if @count == 0
    out = first
    
    @count -= 1
    @count.times {|i| @store[i] = @store[i+1]}
    
    out
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each(&prc)
    prc ||= Proc.new {|el| el}
    @count.times {|i| prc.call(@store[i])}
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless other.length == @count
    @count.times {|i| return false unless other[i] == self[i] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(@store.length * 2)
    capacity.times {|i| new_store[i] = @store[i]}
    @store = new_store
  end
end
