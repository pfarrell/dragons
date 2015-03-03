class App < Sinatra::Application
  get "/query" do 
    haml :query, locals: { query: nil, results: nil }
  end

  post "/query" do
    haml :query, locals: { query: params[:query], results: session[:db].run_query(params[:query]).all }
  end
end
