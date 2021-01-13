require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

# linked list: FIRST is oldest, LAST is youngest

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    unless @map[key]
      calc!(key) 
      eject! if count > @max
    end

    node = @map[key]
    update_node!(node)

    node.val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key) # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.append(key, val)
    @map[key] = @store.last
  end

  def update_node!(node) # suggested helper method; move a node to the end of the list
    node.remove
    @store.append(node.key, node.val)
    @map[node.key] = @store.last
  end

  def eject!
    node = @store.first
    @map.delete(node.key)
    node.remove
  end
end
