require 'spec_helper'
require 'byebug'


def setup_session(conn)
  post "/database?conn=#{conn}"
  #expect(last_response).to be_ok
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

  it "has a notes route" do
    setup_session(conn)

    post "/notes", {note: "test note"}
    expect(last_response).to be_redirect
  end

  it "has a search route" do
    setup_session(conn)
    get "/search"
    expect(last_response).to be_ok
  end

  it "has a search route" do
    setup_session(conn)
    get "/search?query=test"
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
    post "/query", query: "select 1"
    expect(last_response).to be_ok
  end

  it "handles bad queries via query route" do
    setup_session(conn)
    post "/query", query: "select blorg from bloog"
    expect(last_response.status).to eq(400)
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

  it "has a routine route" do
    setup_session(conn)
    get "/routines.json"
    expect(last_response).to be_ok

    hsh=JSON.parse(last_response.body)
    get "/routines/#{hsh.first}"
    expect(last_response).to be_ok
  end

  it "has a logout route" do
    setup_session(conn)
    get "/"
    expect(last_response).to be_redirect
    get "/logout"
    expect(last_response).to be_redirect
  end

  it "has a database route for reusing old connections" do
    setup_session(conn)
    db=Database.first
    get "/database/#{db.id}"
    expect(last_response).to be_redirect
  end

  it "has a database route" do
    setup_session(conn)
    get "/database"
    expect(last_response).to be_ok
  end

  it "has a connections route" do
    setup_session(conn)
    get "/connections"
    expect(last_response).to be_ok
  end

  it "handles errors" do
    setup_session(conn)
    get "/exception"
    expect(last_response.status).to eq(500)
  end

  it "has a views route" do
    setup_session(conn)
    get "/views"
    expect(last_response).to be_ok
  end

  it "has a view route" do
    setup_session(conn)
    get "/views.json"
    expect(last_response).to be_ok

    hsh=JSON.parse(last_response.body)
    get "/views/#{hsh.first}"
    expect(last_response).to be_ok
  end

  it "creates and deletes database connections" do
    db = Database.find_or_create(connection: "test")
    delete "/database/#{db.id}"
    expect(last_response).to be_redirect

  end

end
