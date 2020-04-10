require 'sinatra'

set :port, 5000
set :bind, '0.0.0.0'

get '/' do
  "Home page"
end
