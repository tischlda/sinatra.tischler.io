class BaseController < Sinatra::Base
  before do
    cache_control :public, max_age: 300
  end
end