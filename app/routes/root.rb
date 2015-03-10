class App < Sinatra::Application
  get "/" do
    redirect "/database" if connected?
    haml :index, locals:{connections:Database.all}
  end

  get "/logout" do
    session[:db] = nil
    redirect "/"
  end
end

