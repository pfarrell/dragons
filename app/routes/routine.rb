class App < Sinatra::Application

  get "/routines/:routine_name" do
    haml :routine, locals: { routine: session[:db].routine(params[:routine_name]) }
  end

  get "/routines" do
    data=session[:db].routines.sort
    respond_to do |wants|
      wants.json { data.to_json }
      wants.html {
        props={}
        props["routine"]={value: lambda{|x| x}, link: lambda{|x| "/routines/#{x}"}}
        haml :collection, locals: {title: "Routines", model: {header: props, data: data}}
      }
    end
  end
end
