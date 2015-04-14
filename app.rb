$: << File.expand_path('../app', __FILE__)

require 'sinatra'
require 'sinatra/url_for'
require 'sinatra/respond_to'
require 'sinatra/cookies'
require 'securerandom'
require 'sequel'
require 'haml'

class App < Sinatra::Application
  helpers Sinatra::UrlForHelper
  helpers Sinatra::Cookies
  register Sinatra::RespondTo
  use Rack::MethodOverride

  enable :sessions
  set :session_secret, ENV["APP_SESSION_SECRET"] || "youshouldreallychangethis"
  set :views, Proc.new { File.join(root, "app/views") }
  set :show_exceptions, false

  before do
    response.set_cookie(:appc, value: SecureRandom.uuid, expires: Time.now + 3600 * 24 * 365 * 10) if request.cookies["bmc"].nil?
    update_route
  end

  error do
    haml :error, locals: {error: env['sinatra.error'].message}
  end

  helpers do
    def connected?
      !session[:db].nil?
    end

    def path
      request.fullpath
    end

    def routes
      AppRoute.order(Sequel.desc(:last_used)).all
    end

    def update_route
      app_route=AppRoute.find(path:request.path)
      return if app_route.nil?
      app_route.last_used=Time.now
      app_route.save
    end

    def notes
      return nil if session[:db].nil?
      p=Path.where(database: Database[session[:db]], path: path)
      p.nil? ? nil : Note.where(path: p)
    end

    def connections
      Database.order(Sequel.desc(:last_used)).all
    end

    def current_connection
      Database[session[:db]]
    end

    def host
      ret= session[:db].nil? ? "Unconnected" : Database[session[:db]].host
    end

  end
end

require 'models'
require 'routes'
