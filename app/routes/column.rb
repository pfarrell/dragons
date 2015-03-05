class App < Sinatra::Application
  def column_hash
    summary = Hash.new{|hash, key| hash[key] = Array.new;}
    session[:db].columns.map{|x| summary[x[:column_name]] << x[:table_name]}
    summary
  end

  get "/columns" do
    haml :columns, locals: { columns: column_hash.to_a.sort.to_h}
  end

  get "/column/:column_name" do
    haml :column, locals: {column: column_hash[params[:column_name]]}
  end
end
