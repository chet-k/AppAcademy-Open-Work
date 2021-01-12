class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      @count += 1
      resize! if @count >= num_buckets
      self[key] << key
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1 if self.include?(key)
    self[key].delete(key)
  end

  private

  def [](key)
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    
    @store.each do |bucket| 
      bucket.each {|key| new_store[key.hash % (num_buckets * 2)] << key}
    end

    @store = new_store
  end
end
