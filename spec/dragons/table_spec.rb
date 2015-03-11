require 'spec_helper'

describe Table do

  let(:db){ Database.new(connection: '{"adapter":"postgres", "host":"localhost", "database":"pigeon"}')}

  it "can get primary keys" do
    table = db.table(db.tables.first.to_s)
    expect(table.primary_key).to_not be_nil
  end
end

