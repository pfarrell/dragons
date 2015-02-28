class App < Sinatra::Application
  get "/database" do 
    haml :database, locals: {model: session[:db], tables: session[:db].tables} 
  end

  post "/database" do
    session[:db] = Database.new(params[:conn])
    haml :database, locals: {model: session[:db], tables: session[:db].tables} 
  end

  get "/database/tables" do
    haml :tables, locals: {model: session[:db].tables}
  end

  get "/table/:table_name" do
    props={}
    props["field"]={value: lambda{|x| x[0]}}
    props["type"]={value: lambda{|x| x[1][:db_type]}}
    haml :table, locals: {header: props, data: session[:db].table(params[:table_name])}
  end

end
