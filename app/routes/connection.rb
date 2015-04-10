class App < Sinatra::Application
  get "/connections" do
    haml :connection, locals:{model: Database.order(Sequel.desc(:last_used)).all}
  end
end

