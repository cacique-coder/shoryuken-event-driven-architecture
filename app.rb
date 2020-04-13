require 'mongoid'
require 'aws-sdk-sns'
require 'shoryuken'


Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

class User
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :reseted_at, type: Time
end

class UserCreatedWorker
  include Shoryuken::Worker

  shoryuken_options \
    queue: ENV.fetch('USER_CREATED_EVENT_QUEUE_NAME'),
    auto_delete: true,
    body_parser: :json

  def perform(sqs_msg, attributes)
    user = User.find(attributes['_id']["$oid"])
    # In a real scenario we will use the user for the next action
    User.all.map { |user| user.touch(:reseted_at) }
  end
end
