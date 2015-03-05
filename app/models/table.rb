class Table
  attr_accessor :conn, :name, :indexes, :foreign_keys

  def initialize(conn, name)
    @conn=conn
    @name=name
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
