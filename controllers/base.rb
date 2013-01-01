class BaseController < Sinatra::Base
  helpers Sinatra::ContentFor
  helpers Gravatarify::Helper

  before do
    cache_control :public, max_age: 300
  end
end