require 'spec_helper'
require 'byebug'


def setup_session(conn)
  post "/database?conn=#{conn}"
  expect(last_response).to be_ok
end


describe 'App' do
  let (:conn) {"postgres://localhost/pigeon"}

  it "should allow access to the home page", :skip_before_filter do
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

  it "has a table route" do
    setup_session(conn)
    get "/tables.json"
    expect(last_response).to be_ok

    hsh=JSON.parse(last_response.body)
    get "/tables/#{hsh.first}"
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

  it "has a search route" do
    setup_session(conn)
    get "/search"
    expect(last_response).to be_ok
  end

  it "has a search route" do
    setup_session(conn)
    post "/search?query=test"
    expect(last_response).to be_ok
  end

  it "has a views route" do
    setup_session(conn)
    get "/views"
    expect(last_response).to be_ok
  end

  it "has a query route" do
    setup_session(conn)
    get "/query"
    expect(last_response).to be_ok
  end

  it "answers queries via query route" do
    setup_session(conn)
    post "/query?query=test"
    expect(last_response).to be_ok
  end

  it "has a routines.json route" do
    setup_session(conn)
    get "/routines.json"
    expect(last_response).to be_ok
  end

  it "has a routines route" do
    setup_session(conn)
    get "/routines"
    expect(last_response).to be_ok
  end
end
