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
  
  def foreign_key_header
    props={}
    props["Name"]={value: lambda{|x| x[:name]}}
    props["Columns"]={value: lambda{|x| x[:columns].join(", ")}}
    props["Foreign Table"]={value: lambda{|x| x[:table]}, link: lambda{|x| "/tables/#{x[:table]}"}}
    props["Foreign Column"]={value: lambda{|x| x[:key].join(", ")}}
    props
  end
  
  get "/tables/:table_name" do
    table = Database[session[:db]].table(params[:table_name])
    haml :table, locals: {
      table_struct: {header:table_header, data:table.columns.sort},
      index_struct: {header:index_header, data:table.indexes.sort},
      routine_struct: {header:routine_header, data:table.routines.sort},
      foreign_key_struct: {header:foreign_key_header, data: table.foreign_keys},
      table: table
    }
  end

  get "/tables" do
    data = Database[session[:db]].tables.sort
    respond_to do |wants|
      wants.json { data.to_json }
      wants.html {
        props={}
        props["Table Name"]={value: lambda{|x| x}, link: lambda{|x| "/tables/#{x}"}}
        haml :tables, locals: {model: {header: props, data: Database[session[:db]].tables.sort}}
      }
    end
  end
end
