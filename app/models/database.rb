require 'json'
class Database < Sequel::Model
 one_to_many :paths
 one_to_many :queries

  def conn
    JSON.parse(self.connection)
  end

  def tables
    Sequel.connect(conn).tables
  end

  def table(name)
    Table.new(Sequel.connect(conn), name)
  end

  def view(name)
    View.new(Sequel.connect(conn), name)
  end

  def adapter
    conn["adapter"]
  end

  def host
    conn["host"]
  end

  def database
    conn["database"]
  end

  def default_schema
    cn = conn['adapter']
    return 'dbo' if cn =~ /^tinytds/
    return database if cn=~ /^mysql/
    return 'public'
  end

  def views
    Sequel.connect(conn).views
  end

  def routines(schema=default_schema)
    Sequel.connect(conn)[Sequel.qualify("information_schema", "routines")]
      .select(:routine_name)
      .where(routine_schema: schema)
      .map{|x| x[:routine_name] || x[:ROUTINE_SCHEMA]} #upcase is hack for mysql
  end

  def routine(name, schema=default_schema)
    ret={}
    Sequel.connect(conn)[Sequel.qualify("information_schema", "routines")]
      .where({routine_schema: schema, routine_name: name})
      .first
      .map{|k,v| ret[k.to_s.downcase.to_sym] = v}
    ret[:routine_definition] = mssql_routine(name, schema).map{|x| x[:text]}.join if adapter =~ /^tinytds/
    ret
  end

  def mssql_routine(name, schema)
    #object_definition also got truncated
    #Sequel.connect(conn).fetch("SELECT OBJECT_DEFINITION(OBJECT_ID('#{name}')) as routine_definition")
    Sequel.connect(conn).fetch("EXEC sp_helptext'#{name}'")
  end

  def run_query(query)
    Sequel.connect(conn).fetch(query)
  end

  def columns
    Sequel.connect(conn).fetch("Select table_name, column_name from information_schema.columns where table_schema = '#{default_schema}'")
  end
end
