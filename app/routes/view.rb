class App < Sinatra::Application
  def view_header
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

  get "/views" do
    props={}
    props["view"]={value: lambda{|x| x}, link: lambda{|x| "/views/#{x}"}}

    haml :collection, locals: {title: "Views", model: {header: props, data: Database[session[:db]].views.sort}}
  end

  get "/views/:view_name" do
    view = Database[session[:db]].view(params[:view_name])
    haml :view, locals: {
      view_struct: {header:view_header, data:view.columns},
      index_struct: {header:index_header, data:view.indexes.sort},
      routine_struct: {header:routine_header, data:view.routines.sort},
      foreign_key_struct: {header:foreign_key_header, data: view.foreign_keys},
      view: view
    }
  end
end
