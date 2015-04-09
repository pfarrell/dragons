require './app'
def create_route(path, title)
  route = AppRoute.find_or_create(path: route, title: title)
  route.title=title
  route.path=path
  route.save
end

create_route("/tables", "Tables")
create_route("/views", "Views")
create_route("/routines", "Routines")
create_route("/columns", "Columns")
create_route("/query", "Query")
create_route("/connections", "Connections")

 
