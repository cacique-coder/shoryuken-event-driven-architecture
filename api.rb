require 'sinatra'
require_relative './app'

set :port, 5000
set :bind, '0.0.0.0'

get '/' do
  User.all.to_json
end
