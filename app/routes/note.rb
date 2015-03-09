class App < Sinatra::Application

  post "/notes" do
    path = Path.find_or_create(database: Database[session[:db]], path: params[:path])
    note = Note.new(note: params[:note], path: path)
    note.save
    redirect(params[:path])
  end
end
