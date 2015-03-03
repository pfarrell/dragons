class App < Sinatra::Application

  get "/table/:table_name" do
    table = session[:db].table(params[:table_name])
    props={}
    props["field"]={value: lambda{|x| x[0]}}
    props["type"]={value: lambda{|x| x[1][:db_type]}}
    props["primary key?"]={value: lambda{|x| x[1][:primary_key]}}
    haml :table, locals: {
      header: props,
      table: table
    }
  end

end
