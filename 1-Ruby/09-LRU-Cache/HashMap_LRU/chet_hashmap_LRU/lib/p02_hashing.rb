class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    int_out = 1
    self.each_with_index do |el, i|
      int_out = int_out ^ (el.hash + i)
    end
    int_out
  end
end

class String
  def hash
    int_out = 1
    self.each_char.with_index do |c, i|
      int_out = int_out ^ (c.ord.hash + i)
    end
    int_out
  end
end

class Hash
  def hash
    keys_int, vals_int = 1, 1
    self.keys.each   {|k| keys_int = keys_int ^ k.hash}
    self.values.each {|v| vals_int = vals_int ^ v.hash}
    vals_int ^ keys_int
  end
end
