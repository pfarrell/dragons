require 'benchmark'

class App < Sinatra::Application
  def execution_format(exe)
    return {user: exe.cutime, system: exe.cstime, real: exe.real, total: exe.total, user_cpu: exe.utime}
  end

  get "/query" do 
    query = Query[params[:history].to_i].query unless params[:history].nil?
    query ||= params[:q]
    haml :query, locals: { query: query, results: nil, error: nil }
  end

  post "/query" do
    content_type :json
    query_history = Query.new(query: params[:query], database: Database[session[:db]])
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

  get "/query/history" do
    redirect url_for("/query/history/1")
  end

  get "/query/history/:page" do
    page = params[:page].to_i
    haml :query_history, locals: {queries: Query.where(database_id: session[:db]).order(Sequel.desc(:id)).paginate(page, 25), nxt: page + 1, prev: page -1}
  end
end
