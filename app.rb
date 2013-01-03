require 'sinatra/content_for'
require './controllers/scss'
require './controllers/user'

class App < Sinatra::Base
  helpers Sinatra::ContentFor

  configure :production do
    set :static_cache_control, [:public, :max_age => 300]
  end

  use ScssController
  use UserController

  get '/' do
    slim :index
  end
end