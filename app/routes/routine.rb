class App < Sinatra::Application

  get "/routines/:routine_name" do
    haml :routine, locals: { routine: Database[session[:db]].routine(params[:routine_name]) }
  end

  get "/routines" do
    data=Database[session[:db]].routines.sort
    props={}
    props["routine"]={value: lambda{|x| x}, link: lambda{|x| "/routines/#{x}"}}
    haml :collection, locals: {title: "Routines", model: {header: props, data: data}}
  end
end
