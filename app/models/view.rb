class View
  def self.search(conn, query)
    conn.views.select{|view| view =~/#{query}/i}
  end
end
