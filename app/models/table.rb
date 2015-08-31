class Table
  attr_accessor :conn, :name, :indexes, :foreign_keys

  def initialize(conn, name)
    @conn=conn
    @name=name
  end

  def self.search(conn, query)
    conn.tables.select{|table| table =~/#{query}/i}
  end

  def select
    cols = columns.map{|k,v| k.to_s}.join(", ")
    case @conn["adapter"]
      when "tinytds"
        "SELECT TOP 100 #{cols} FROM #{name}"
      else
        "SELECT #{cols} FROM #{name} LIMIT 100"
    end
  end

  def create
    "CREATE TABLE #{name} (\n"\
    "#{columns.map{|k,v| v.inspect}.join(", ")}"\
    ")"
  end

  def columns
    @conn.schema(@name)
  end

  def indexes
    @conn.indexes(@name)
  end

  def foreign_keys
    @conn.foreign_key_list(@name)
  end

  def data(count=50)
    @conn[@name.to_sym].first(count)
  end

  def primary_key
    columns.select{|x| x[1][:primary_key]}
  end

  def routines
    @conn[Sequel.qualify("information_schema", "routines")]
      .select(:routine_name)
      .where(Sequel.ilike(:routine_definition, "%#{@name}%"))
      .map{|x| x[:routine_name] }
  end
    
end
