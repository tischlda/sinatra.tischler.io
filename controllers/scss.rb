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
      # Without this requests with If-Modified-Since for non existent
      # files could falsely receive 304 instead of 404.
      pass if not File.exists? "#{settings.views}/#{name}.scss"
      
      # Set Last-Modified to modification date of most recently modified
      # .scss-file, as the one requested could include any other.
      last_modified Dir.glob("#{settings.views}/**").map {|f| File.mtime(f) }.max

      scss name.to_sym

    # raised by scss if file not found
    rescue Errno::ENOENT
      raise Sinatra::NotFound.new
    end
  end
end