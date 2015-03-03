class App < Sinatra::Application
  get "/query" do 
    haml :query, locals: { results: nil }
  end

  post "/query" do
    haml :query, locals: { results: session[:db].run_query(params[:query]).all }
  end
end
