class App < Sinatra::Application

  get "/routine/:routine_name" do
    haml :routine, locals: { routine: session[:db].routine(params[:routine_name]) }
  end

end
