# frozen_string_literal: true
require_relative './app'


module Shoryuken
  class EventOrDefaultWorkerRegistry < DefaultWorkerRegistry
    def fetch_worker(queue, message)
      return UserCreatedWorker.new if queue == UserCreatedWorker.shoryuken_options_hash['queue']

      raise NotImplementedError, "#{queue}, #{message.inspect}"
    end
  end
end

Shoryuken.configure_server do |config|
  config.worker_registry = Shoryuken::EventOrDefaultWorkerRegistry.new
  config.add_group('default')
  config.add_queue(ENV.fetch('USER_CREATED_EVENT_QUEUE_NAME'), 1, 'default')
end
