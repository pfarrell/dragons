class App < Sinatra::Application
  get "/search" do
    ret={}
    unless params[:query].nil?
      ret[:tables] = Table.search(session[:db], params[:query]).sort
      ret[:views] = View.search(session[:db], params[:query]).sort
      ret[:routines] = Routine.search(session[:db], params[:query]).sort
      ret[:columns] = Column.search(session[:db], params[:query])
    end
    haml :search, locals: {query: params[:query], results: ret}
  end
end
