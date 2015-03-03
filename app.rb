$: << File.expand_path('../app', __FILE__)

require 'sinatra'
require 'sinatra/url_for'
require 'sinatra/respond_to'
require 'sinatra/cookies'
require 'securerandom'
require 'sequel'
require 'haml'
require 'byebug'

class App < Sinatra::Application
  helpers Sinatra::UrlForHelper
  helpers Sinatra::Cookies
  register Sinatra::RespondTo

  enable :sessions
  set :session_secret, ENV["APP_SESSION_SECRET"] || "youshouldreallychangethis"
  set :views, Proc.new { File.join(root, "app/views") }
  set :show_exceptions, false

  before do
    response.set_cookie(:appc, value: SecureRandom.uuid, expires: Time.now + 3600 * 24 * 365 * 10) if request.cookies["bmc"].nil?
  end

  error do
    byebug
    haml :error, locals: {error: env['sinatra.error'].message}
  end

  helpers do
    def connected?
      !session[:db].nil?
    end

    def tables
      session[:db].tables if connected?
    end

    def views
      session[:db].views if connected?
    end

    def routines
      session[:db].routines if connected?
    end
  end
end

require 'models'
require 'routes'
