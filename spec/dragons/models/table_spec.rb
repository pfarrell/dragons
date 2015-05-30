require 'spec_helper'

class FakeConn < Hash
 
  def initialize(adapter)
    self["adapter"] = adapter
  end

  def schema(str)
    return ["a", "b", "c"]
  end
end

describe Table do

  it "can create a select statement" do
    conn = FakeConn.new("tinytds")
    
    table = Table.new(conn, "table")
    expect(table.select).to eq("SELECT TOP 100 a, b, c FROM table")
  end
  
  it "can create a select statement" do
    conn = FakeConn.new("postgres")
    
    table = Table.new(conn, "table")
    expect(table.select).to eq("SELECT a, b, c FROM table LIMIT 100")
  end
end
