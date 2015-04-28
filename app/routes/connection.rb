class App < Sinatra::Application
  get "/connections" do
    haml :connections, locals:{model: Database.order(Sequel.desc(:last_used)).all}
  end

  post "/connections" do
    conn = Database.new
    conn.connection = params.select{|x| !x.nil? && x != ""}.to_json
    conn.save
    haml :connections, locals:{model: Database.order(Sequel.desc(:last_used)).all}
  end
end

