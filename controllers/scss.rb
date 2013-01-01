require './controllers/base'

class ScssController < BaseController
  configure do
    set :views, './views/scss'
  end

  configure :production do
    set :scss, style: :compressed
  end

  get '/stylesheets/:name.css' do |name|
    begin
      scss name.to_sym
    rescue Errno::ENOENT
      raise Sinatra::NotFound.new
    end
  end
end