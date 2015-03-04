class App < Sinatra::Application
  get "/database" do 
    haml :database, locals: { model: session[:db] } 
  end

  post "/database" do
    session[:db] = Database.new(params[:conn])
    haml :database, locals: { model: session[:db] } 
  end

  get "/database/columns" do
    summary = Hash.new{|hash, key| hash[key] = Array.new;}
    session[:db].columns.map{|x| summary[x[:column_name]] << x[:table_name]}
    haml :columns, locals: { columns: summary }
  end
end
