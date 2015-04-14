class App < Sinatra::Application
  get "/query" do 
    haml :query, locals: { query: nil, results: nil, error: nil }
  end

  post "/query" do
    content_type :json
    begin
      q=Database[session[:db]].run_query(params[:query])
      status 200
      return {query: params[:query], columns: q.columns, data: q.all}.to_json
    rescue Exception => ex
      status 400
      return {error_message: ex.message}.to_json
    end
  end
end
