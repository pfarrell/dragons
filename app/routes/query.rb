class App < Sinatra::Application
  get "/query" do 
    haml :query, locals: { query: nil, results: nil, error: nil }
  end

  post "/query" do
    begin
      q=Database[session[:db]].run_query(params[:query])
    rescue Exception => ex
      haml :query, locals: {query: params[:query], results: nil, error: ex.message} 
    end
    respond_to do |wants|
      wants.html{haml :query, locals: { query: params[:query], results: q.all, error: nil }}
      wants.json{ {query: params[:query], columns: q.columns, data: q.all}.to_json }
    end
  end
end
