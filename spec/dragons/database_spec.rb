require 'spec_helper'

describe 'Database' do
  it "can be instantiated with a json string" do
    db = Database.new(connection: '{"adapter":"test", "database":"database"}')
    expect(db.conn["adapter"]).to eq("test")
    expect(db.conn["database"]).to eq("database")
  end
end
