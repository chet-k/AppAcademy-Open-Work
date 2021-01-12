require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      @count += 1
      resize! if @count >= num_buckets
      bucket(key).append(key, val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    bucket(key).remove(key)
  end

  def each(&prc)
    prc ||= Proc.new {|el| el}
    @store.each do |b|
      b.each do |node|
        prc.call([node.key, node.val])
      end
    end
    self
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    
    @store.each do |b| 
      b.each do |node|
        k, v = node.key, node.val
        new_store[k.hash % (num_buckets * 2)].append(k, v)
      end
    end

    @store = new_store
  end

  def bucket(key) 
    @store[key.hash % num_buckets]
  end
end
