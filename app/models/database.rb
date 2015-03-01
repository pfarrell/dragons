class Database
  attr_accessor :conn

  def initialize(conn)
    @conn=conn
  end

  def tables
    Sequel.connect(@conn).tables
  end

  def table(name)
    Sequel.connect(@conn).schema(name)
  end

  def indexes(name)
    Sequel.connect(@conn).indexes(name)
  end

  def foreign_keys(name)
    Sequel.connect(@conn).foreign_key_list(name)
  end

  def table_data(name, count=50)
    Sequel.connect(@conn)[name.to_sym].first(count)
  end

  def routines(schema='public')
    Sequel.connect(@conn)[Sequel.qualify("information_schema", "routines")]
      .select(:routine_name)
      .where(specific_schema: schema)
      .map{|x| x[:routine_name] }
  end

  def routine(name, schema='public')
    Sequel.connect(@conn)[Sequel.qualify("information_schema", "routines")]
      .where({specific_schema: schema, routine_name: name}).first
  end
end
