class App < Sinatra::Application
  get "/search" do
    ret={}
    unless params[:query].nil?
      ret[:tables] = Table.search(Database[session[:db]], params[:query]).sort
      ret[:views] = View.search(Database[session[:db]], params[:query]).sort
      ret[:routines] = Routine.search(Database[session[:db]], params[:query]).sort
      ret[:columns] = Column.search(Database[session[:db]], params[:query]).sort_by{|col| col[:column_name]}
    end
    haml :search, locals: {query: params[:query], results: ret}
  end
end
