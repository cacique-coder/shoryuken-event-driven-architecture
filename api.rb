require 'sinatra'
require_relative './app'

set :port, 5000
set :bind, '0.0.0.0'

get '/' do
  User.all.to_json
end

helpers do
  def parsed_body
    request.body.rewind
    JSON.parse(request.body.read)
  end
end

post "/" do
  user = User.create(parsed_body)
  user.to_json
end
