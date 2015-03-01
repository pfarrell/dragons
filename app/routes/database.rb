class App < Sinatra::Application
  get "/database" do 
    haml :database, locals: {model: session[:db]} 
  end

  post "/database" do
    session[:db] = Database.new(params[:conn])
    haml :database, locals: {
      model: session[:db],
      routines: session[:db].routines,
    } 
  end
end
