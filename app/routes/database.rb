class App < Sinatra::Application
  def stats
    stats={}
    stats["Tables"] = session[:db].tables.count
    stats["Views"] = session[:db].views.count
    stats["Routines"] = session[:db].routines.count
    stats
  end

  def stats_header
    props={}
    props["Object Type"]={value:lambda{|x| x[0]}}
    props["Count"]={value:lambda{|x| x[1]}}
    props
  end

  get "/database" do 
    haml :collection, locals: { title: "Database", model: {header:stats_header, data: stats }} 
  end

  post "/database" do
    session[:db] = Database.new(params[:conn])
    haml :collection, locals: { title: "Database", model: {header:stats_header, data: stats }} 
  end

end
