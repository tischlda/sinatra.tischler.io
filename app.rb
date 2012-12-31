require './models/user'
require 'sinatra/content_for'

class ScssEngine < Sinatra::Base
  configure do
    set :views, './views/scss'
  end

  configure :production do
    set :scss, { :style => :compressed }
  end

  get '/stylesheets/:name.css' do |name|
    begin
      scss name.to_sym
    rescue Errno::ENOENT
      raise Sinatra::NotFound.new
    end
  end
end

class Sinatra::Base
  helpers Sinatra::ContentFor
  helpers Gravatarify::Helper
end

class UserEngine < Sinatra::Base
  configure do
    Mongoid.load!('config/mongoid.yml')
  end

  # match /name and /name.format
  get %r{/(?<name>[^.]+)(\.(?<format>[^.]*))?} do |name, format|
    pass unless @user = User.where(name: name).first
    @user[:vcfUrl] = get_vcf_url name
    @userName = name

    if !format
      slim :user
    else
      case format.to_sym
        when :json then json_result(@user)
        when :vcf then vcf_result(@user)
        else pass
      end
    end
  end

  def get_vcf_url name
    is_default_port = (request.scheme == 'http' && request.port == 80) ||
                      (request.scheme == 'https' && request.port == 443)
    "#{request.scheme}://#{request.host}#{is_default_port ? '' : ':' + request.port.to_s}/#{name}.vcf"
  end

  def vcf_result value
    content_type 'text/vcard'
    erb :vcf
  end

  def json_result value
    content_type :json
    value.to_json
  end
end

class App < Sinatra::Base
  use ScssEngine
  use UserEngine

  get '/' do
    slim :index
  end
end