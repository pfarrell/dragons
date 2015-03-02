class Database
  attr_accessor :conn

  def initialize(conn)
    @conn=conn
  end

  def tables
    Sequel.connect(@conn).tables
  end

  def table(name)
    Table.new(Sequel.connect(@conn), name)
  end


  def routines(schema='public')
    Sequel.connect(@conn)[Sequel.qualify("information_schema", "routines")]
      .select(:routine_name)
      .where(routine_schema: schema)
      .map{|x| x[:routine_name] }
  end

  def routine(name, schema='public')
    Sequel.connect(@conn)[Sequel.qualify("information_schema", "routines")]
      .where({specific_schema: schema, routine_name: name}).first
  end
end
