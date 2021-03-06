class View
  attr_accessor :conn, :name, :indexes, :foreign_keys

  def initialize(conn, name)
    @conn=conn
    @name=name
  end

  def self.search(conn, query)
    conn.views.select{|view| view =~/#{query}/i}
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

  def definition
    conn.fetch("Select view_definition from information_schema.views where table_name = '#{@name}'").first[:view_definition]
  end

  def routines
    @conn[Sequel.qualify("information_schema", "routines")]
      .select(:routine_name)
      .where(Sequel.ilike(:routine_definition, "%#{@name}%"))
      .map{|x| x[:routine_name] }
  end
    
end
