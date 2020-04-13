require 'sinatra'
require_relative './app'

set :port, 5000
set :bind, '0.0.0.0'
set :user_created, "User created"
get '/' do
  User.all.to_json
end

helpers do
  def parsed_body
    request.body.rewind
    JSON.parse(request.body.read)
  end

  def notify(topic, data, type)
    client = Aws::SNS::Client.new(
      region: ENV.fetch('AWS_REGION'),
      access_key_id: ENV.fetch('AWS_ACCESS_KEY'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY')
    )

    puts data

    client.publish({
      topic_arn: topic,
      message: data,
      subject: type
    })
  end
end

post "/" do
  user = User.create(parsed_body)
  if user.valid?
    notify(ENV.fetch('USER_CREATED_EVENT_TOPIC'), user.to_json, settings.user_created)
    user.to_json
  else
    user.errors.full_messages.to_json
  end
end
