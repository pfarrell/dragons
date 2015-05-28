class App < Sinatra::Application
  def column_hash
    summary = Hash.new{|hash, key| hash[key] = Array.new;}
    Database[session[:db]].columns.map{|x| summary[x[:column_name].downcase] << x[:table_name]}
    summary.sort.to_h
  end

  get "/columns" do
    data = column_hash.to_a.sort.to_h
    respond_to do |wants|
      wants.html { haml :columns, locals: { columns: data } }
      wants.json { data.to_json }
    end
  end

  get "/columns/:column_name" do
    haml :column, locals: {column: params[:column_name], columns: column_hash[params[:column_name].downcase]}
  end
end
