class Routine
  def self.search(conn, query)
    conn.routines.select{|x| x=~/#{query}/}
  end
end
