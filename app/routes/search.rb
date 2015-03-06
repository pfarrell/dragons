class App < Sinatra::Application
  post "/search" do
    ret={}
    ret[:tables] = Table.search(session[:db], params[:query]).sort
    ret[:views] = View.search(session[:db], params[:query]).sort
    ret[:routines] = Routine.search(session[:db], params[:query]).sort
    ret[:columns] = Column.search(session[:db], params[:query])
    haml :search, locals: {query: params[:query], results: ret}
  end

  get "/search" do
    haml :search, locals: {query: nil, results: []}
  end
end
