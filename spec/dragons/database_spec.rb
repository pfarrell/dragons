require 'spec_helper'

describe 'Database' do
  it "can be instantited with a connection string" do
    db = Database.new("test://database")
    expect(db.conn).to eq "test://database"
  end

  it "can be instantiated with a json string" do
    db = Database.new('{"adapter":"test", "database":"database"}')
    expect(db.conn["adapter"]).to eq("test")
    expect(db.conn["database"]).to eq("database")
  end
end
