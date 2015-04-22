require 'benchmark'

class App < Sinatra::Application
  def execution_format(exe)
    return {user: exe.cutime, system: exe.cstime, real: exe.real, total: exe.total, user_cpu: exe.utime}
  end

  get "/query" do 
    haml :query, locals: { query: nil, results: nil, error: nil }
  end

  post "/query" do
    content_type :json
    query_history = Query.new(query: params[:query])
    query_history.save
    begin
      q=[]
      exe=Benchmark.measure {
        q=Database[session[:db]].run_query(params[:query])
      }
      status 200
      return {query: params[:query], columns: q.columns, data: q.all, execution: execution_format(exe)}.to_json
    rescue Exception => ex
      status 400
      return {error_message: ex.message}.to_json
    end
  end
end
