class View
  def self.search(conn, query)
    conn.views.select{|table| table =~/query/i}
  end
end
