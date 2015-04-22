require 'logger'

$console = ENV['RACK_ENV'] == 'development' ? Logger.new(STDOUT) : nil
DB = Sequel.connect(ENV['DRAGONS_DB'] || 'sqlite://config.db',logger: $console)

DB.sql_log_level = :debug
DB.extension(:pagination)

Sequel::Model.plugin :timestamps
Sequel::Model.plugin :json_serializer

#non-config stuff
require 'models/database'
require 'models/table'
require 'models/view'
require 'models/column'
require 'models/routine'

#config related stuff
require 'models/path'
require 'models/note'
require 'models/app_route'
require 'models/query'
