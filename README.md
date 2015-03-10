<p align="center"><img src="https://patf.net/images/dragons.jpg" alt="Here Be Dragons!"></p>

#Dragons

How many sql query tools have I created? Like 4?

You know what I've never created? One that was specifically for dealing with investigating legacy code bases. Wouldn't that be useful? A tool designed to help you make sense of a codebase you've never used?

This one brings together some things I've learned over the past few years

Features
  * search across tables, views, column names, function definitions, and stored procedure definitions
  * column name to table view
  * attach notes to any object
  * query interface

Planned
  * syntax highlighting for sql
  * visualization

Built using [sequel](http://sequel.jeremyevans.net/) so that you can connect and analyze a number of different database types, but
it remains to be seen how far we can take it.

In future, I'd like to add code exploration to this as well, but let's just see if we can get this 
vision shipped.

Things to come

* network-graph displays of table relations supporting inferred foreign keys
* read only queries

##Install

```
   brew install freetds
   bundle install
   bower install
   bundle exec rackup
```

