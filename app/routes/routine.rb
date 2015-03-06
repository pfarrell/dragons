class App < Sinatra::Application

  get "/routines/:routine_name" do
    haml :routine, locals: { routine: session[:db].routine(params[:routine_name]) }
  end

  get "/routines" do
    props={}
    props["routine"]={value: lambda{|x| x}, link: lambda{|x| "/routines/#{x}"}}

    haml :collection, locals: {title: "Routines", model: {header: props, data: session[:db].routines.sort}}
  end

end
