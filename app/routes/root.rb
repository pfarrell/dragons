class App < Sinatra::Application
  get "/" do
    haml :index
  end

  get "/logout" do
    session[:db] = nil
    redirect "/"
  end
end

