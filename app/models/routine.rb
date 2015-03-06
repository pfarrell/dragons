class Routine
  def self.search(conn, query)
    conn.routines.select{|x| x=~/#{query}/i}
  end
end
