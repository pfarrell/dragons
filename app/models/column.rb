class Column
  def self.search(conn, query)
    conn.columns.all.select{|x| x[:column_name]=~/#{query}/}
  end
end
