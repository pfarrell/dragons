require 'json'
class Database < Sequel::Model

  def conn
    JSON.parse(self.connection)
  end

  def tables
    Sequel.connect(conn).tables
  end

  def table(name)
    Table.new(Sequel.connect(conn), name)
  end

  def default_schema
    cn = conn['adapter']
    return 'dbo' if cn =~ /^tinytds/
    return 'public'
  end

  def views
    Sequel.connect(conn).views
  end

  def routines(schema=default_schema)
    Sequel.connect(conn)[Sequel.qualify("information_schema", "routines")]
      .select(:routine_name)
      .where(routine_schema: schema)
      .map{|x| x[:routine_name] }
  end

  def routine(name, schema=default_schema)
    Sequel.connect(conn)[Sequel.qualify("information_schema", "routines")]
      .where({specific_schema: schema, routine_name: name}).first
  end

  def run_query(query)
    Sequel.connect(conn).fetch(query)
  end

  def columns
    Sequel.connect(conn).fetch("Select table_name, column_name from information_schema.columns where table_schema = '#{default_schema}'")
  end
end
