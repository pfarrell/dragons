class App < Sinatra::Application
  def table_header
    props={}
    props["field"]={value: lambda{|x| x[0]}}
    props["type"]={value: lambda{|x| x[1][:db_type]}}
    props["primary key?"]={value: lambda{|x| x[1][:primary_key]}}
    props
  end

  def index_header
    props={}
    props["name"]={value: lambda{|x| x[0]}}
    props["columns"]={value: lambda{|x| x[1][:columns].join(', ')}}
    props
  end

  get "/table/:table_name" do
    table = session[:db].table(params[:table_name])
    haml :table, locals: {
      table_struct: {header:table_header, data:table.columns},
      index_struct: {header:index_header, data:table.indexes},
      table: table
    }
  end

end
