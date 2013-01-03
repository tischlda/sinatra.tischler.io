require './controllers/base'
require './models/user'

class UserController < BaseController
  helpers Sinatra::ContentFor
  helpers Gravatarify::Helper

  configure do
    Mongoid.load!('./config/mongoid.yml')
    set :views, './views'
  end

  # match /name and /name.format
  get %r{/(?<name>[^.]+)(\.(?<format>[^.]*))?} do |name, format|
    pass unless @user = User.where(name: name).first
    @user[:vcfUrl] = get_vcf_url name
    
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
    value.to_json except: :_id
  end
end