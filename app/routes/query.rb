class App < Sinatra::Application
  get "/query" do 
    haml :query, locals: { query: nil, results: nil, error: nil }
  end

  post "/query" do
    begin
    haml :query, locals: { query: params[:query], results: session[:db].run_query(params[:query]).all, error: nil }
    rescue Exception => ex
      haml:query, locals: {query: params[:query], results: nil, error: ex.message} 
    end
  end
end
