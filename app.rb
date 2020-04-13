require 'mongoid'
require 'aws-sdk-sns'

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

class User
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :reseted_at, type: Time
end
