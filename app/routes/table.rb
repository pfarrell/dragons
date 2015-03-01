class App < Sinatra::Application

  get "/table/:table_name" do
    props={}
    props["field"]={value: lambda{|x| x[0]}}
    props["type"]={value: lambda{|x| x[1][:db_type]}}
    haml :table, locals: {
      table_name: params[:table_name],
      header: props, 
      data: session[:db].table(params[:table_name].to_sym), 
      indexes: session[:db].indexes(params[:table_name].to_sym),
      foreign_keys: session[:db].foreign_keys(params[:table_name].to_sym),
      table_data: session[:db].table_data(params[:table_name].to_sym)
    }
  end

end
