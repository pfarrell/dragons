class App < Sinatra::Application
  get "/views" do
    props={}
    props["view"]={value: lambda{|x| x}, link: lambda{|x| "/views/#{x}"}}

    haml :collection, locals: {title: "Views", model: {header: props, data: session[:db].views.sort}}
  end
end
