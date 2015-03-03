require 'json'
class Database
  attr_accessor :conn

  def initialize(conn)
    @conn= conn=~/^{/ ? JSON.parse(conn) : conn
  end

  def tables
    Sequel.connect(@conn).tables.sort
  end

  def table(name)
    Table.new(Sequel.connect(@conn), name)
  end

  def default_schema
    cn = @conn['adapter'] if @conn.class == Hash
    return 'dbo' if cn =~ /^tinytds/
    return 'public'
  end

  def views
    Sequel.connect(@conn).views.sort
  end

  def routines(schema=default_schema)
    Sequel.connect(@conn)[Sequel.qualify("information_schema", "routines")]
      .select(:routine_name)
      .where(routine_schema: schema)
      .map{|x| x[:routine_name] }
      .sort
  end

  def routine(name, schema=default_schema)
    Sequel.connect(@conn)[Sequel.qualify("information_schema", "routines")]
      .where({specific_schema: schema, routine_name: name}).first
  end

  def run_query(query)
    Sequel.connect(@conn).fetch(query)
  end
end
