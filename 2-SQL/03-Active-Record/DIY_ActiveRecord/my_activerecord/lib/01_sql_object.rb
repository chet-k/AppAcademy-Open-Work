require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  attr_accessor :id

  def self.columns
    return @columns if @columns
    cols = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        "#{self.table_name}"
      LIMIT
        0
    SQL
    @columns = cols.map!(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name)  { self.attributes[name] }
      define_method("#{name}=") { |value| self.attributes[name] = value }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map { |params| self.new(params) }
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
      WHERE
        #{self.table_name}.id = #{id}
    SQL
    result.length == 0 ? nil : self.new(result.first)
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      if self.class.columns.include?(attr_name)
        self.send("#{attr_name}=",value)
      else
        raise "unknown attribute '#{attr_name}'" 
      end
    end
  end

  def attributes
    @attributes ||= {} 
  end

  def attribute_values
    self.class.columns.map {|col| self.send(col)}
  end

  def insert
    cols = self.class.columns[1..-1]
    column_names = cols.map(&:to_s).join(", ")
    question_marks = (["?"] * cols.length).join(", ")
    
    DBConnection.execute(<<-SQL, *attribute_values[1..-1])
      INSERT INTO
        #{self.class.table_name} (#{column_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    cols = self.class.columns[1..-1].map {|attr_name| "#{attr_name} = ?" }
    query_set = cols.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values[1..-1], self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{query_set}
      WHERE
        id = ?
    SQL
  end

  def save
    if self.id.nil? 
      insert
    else
      update
    end
  end
end
