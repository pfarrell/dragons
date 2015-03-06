class App < Sinatra::Application
  def table_header
    props={}
    props["field"]={value: lambda{|x| x[0]}, link: lambda{|x| "/columns/#{x[0]}"}}
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

  def routine_header
    props={}
    props["name"]={value: lambda{|x| x}, link: lambda{|x| "/routines/#{x}"}}
    props
  end
  
  get "/tables/:table_name" do
    table = session[:db].table(params[:table_name])
    haml :table, locals: {
      table_struct: {header:table_header, data:table.columns.sort},
      index_struct: {header:index_header, data:table.indexes.sort},
      routine_struct: {header:routine_header, data:table.routines.sort},
      table: table
    }
  end

  get "/tables" do
    props={}
    props["table"]={value: lambda{|x| x}, link: lambda{|x| "/tables/#{x}"}}

    haml :collection, locals: {title: "Tables", model: {header: props, data: session[:db].tables.sort}}
  end
end
