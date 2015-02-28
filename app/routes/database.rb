class App < Sinatra::Application
  get "/database" do 
    haml :database, locals: {model: session[:db], tables: session[:db].tables} 
  end

  post "/database" do
    session[:db] = Database.new(params[:conn])
    haml :database, locals: {model: session[:db], tables: session[:db].tables} 
  end

  get "/database/tables" do
    haml :tables, locals: {model: session[:db].tables}
  end

end
