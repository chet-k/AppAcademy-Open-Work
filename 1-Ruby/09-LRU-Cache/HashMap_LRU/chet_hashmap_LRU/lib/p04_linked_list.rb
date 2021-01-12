class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next, @tail.prev = @tail, @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each {|node| return node.val if node.key == key}
    nil
  end

  def include?(key)
    any? {|node| node.key == key}
  end

  def append(key, val)
    unless include?(key)
      new_node = Node.new(key, val)
      new_node.prev, new_node.next = last, @tail
      last.next, @tail.prev = new_node, new_node
    end
  end

  def update(key, val)
    each {|node| node.val = val if node.key == key}
  end

  def remove(key)
    each {|node| node.remove if node.key == key}
  end

  def each(&prc)
    prc ||= Proc.new {|el| el}
    node = first
    until node == @tail
      prc.call(node)
      node = node.next
    end
    self
  end
  
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end