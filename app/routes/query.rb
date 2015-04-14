class App < Sinatra::Application
  get "/query" do 
    haml :query, locals: { query: nil, results: nil, error: nil }
  end

  post "/query" do
    content_type :json
    require 'byebug'
    byebug
    begin
      q=Database[session[:db]].run_query(params[:query])
      return {query: params[:query], columns: q.columns, data: q.all}
    rescue Exception => ex
      status 500
      return {error_message: ex.message}.to_json
    end
  end
end
