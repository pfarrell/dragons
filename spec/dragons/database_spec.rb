require 'spec_helper'

describe 'Database' do
  let(:db){ Database.new(connection: '{"adapter":"test", "host":"localhost", "database":"database"}')}
  it "can be instantiated with a json string" do
    expect(db.conn["adapter"]).to eq("test")
    expect(db.conn["host"]).to eq("localhost")
    expect(db.conn["database"]).to eq("database")
  end

  it "has an adapter method" do
    expect(db.adapter).to eq("test")
  end

  it "has a host method" do
    expect(db.host).to eq("localhost")
  end
 
  it "has a database method" do
    expect(db.database).to eq("database")
  end
end
