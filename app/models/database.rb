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
end
