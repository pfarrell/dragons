class App < Sinatra::Application
  get "/" do
    redirect "/database" if connected?
    haml :index
  end

  get "/logout" do
    session[:db] = nil
    redirect "/"
  end
end

