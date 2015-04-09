class App < Sinatra::Application
  get "/" do
    redirect "/database" if connected?
    haml :index, locals:{connections:Database.order(Sequel.desc(:last_used))}
  end

  get "/logout" do
    session[:db] = nil
    redirect "/"
  end

  get "/exception" do
    raise Exception, "test exception"
  end
end

