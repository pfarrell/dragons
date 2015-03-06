class App < Sinatra::Application
  post "/search" do
    ret={}
    ret[:tables] = Table.search(session[:db], params[:query])
    ret[:views] = View.search(session[:db], params[:query])
    ret[:routines] = Routine.search(session[:db], params[:query])
    ret[:columns] = Column.search(session[:db], params[:query])
    haml :search, locals: {results: ret}
  end
end
