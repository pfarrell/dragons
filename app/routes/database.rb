class App < Sinatra::Application
  def stats
    stats={}
    stats["Tables"] = Database[session[:db]].tables.count
    stats["Views"] = Database[session[:db]].views.count
    stats["Routines"] = Database[session[:db]].routines.count
    stats
  end

  def stats_header
    props={}
    props["Object Type"]={value:lambda{|x| x[0]}, link:lambda{|x| "/#{x[0].downcase}"}}
    props["Count"]={value:lambda{|x| x[1]}, link:lambda{|x| "/#{x[0].downcase}"}}
    props
  end

  get "/database" do 
    haml :collection, locals: { title: "#{current_connection.database}", model: {header:stats_header, data: stats }} 
  end

  get "/database/:id" do
    db=Database[params[:id]] 
    session[:db] = db.id
    db.last_used = Time.now
    db.save
    redirect "/database"
  end

  post "/database" do
    db = Database.find_or_create(connection: params[:conn])
    session[:db] = db.id
    db.last_used = Time.now
    db.save
    redirect "/database"
  end

  delete "/database/:id" do
    Database[params[:id]].delete
    redirect(request.env["HTTP_REFERER"])
  end

end
