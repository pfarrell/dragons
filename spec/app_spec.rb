require 'spec_helper'


def setup_session(conn)
  post "/database?conn=#{conn}"
  expect(last_response).to be_ok
end


describe 'App' do
  let (:conn) { URI.escape('{"adapter":"postgres", "host":"localhost", "database":"pigeon"}') }
  it "should allow access to the home page" do
    get "/"
    expect(last_response).to be_ok
  end

  it "should allow setting a connection string" do
    setup_session(conn)
  end

  it "has a columns route" do
    setup_session(conn)

    get "/columns"
    expect(last_response).to be_ok
  end

  it "has a tables route" do
    setup_session(conn)

    get "/tables"
    expect(last_response).to be_ok
  end

  it "has a columns.json route" do
    setup_session(conn)

    get "/columns.json"
    expect(last_response).to be_ok
  end

  it "has a column route" do
    setup_session(conn)

    #get a test column from the columns route
    get "/columns.json"
    expect(last_response).to be_ok

    hsh=JSON.parse(last_response.body)
    get "/columns/#{hsh.first[0]}"
    expect(last_response).to be_ok
  end
end
