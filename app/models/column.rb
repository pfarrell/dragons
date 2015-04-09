class Column
  def self.search(conn, query)
    conn.columns.all.select{|x| x[:column_name]=~/#{query}/i}.uniq{|x| x[:column_name]}
  end
end
