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
end
