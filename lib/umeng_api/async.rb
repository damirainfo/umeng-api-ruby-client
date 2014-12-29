require "active_support/dependencies"

module UmengApi
  module Async
    autoload :Worker,  "umeng_api/async/worker"
    autoload :Backend, "umeng_api/async/backend"
    autoload :Models, "umeng_api/async/models"

    module Backend
      autoload :Base,         "umeng_api/async/backend/base"
      autoload :Sidekiq,      "umeng_api/async/backend/sidekiq"
    end

    # Defines the queue backend to be used. Resque by default.
    mattr_accessor :backend
    @@backend = :sidekiq

    # Defines the queue in which the background job will be enqueued. Default is :mailer.
    mattr_accessor :queue
    @@queue = :umeng_api_sender

    # Defines the enabled configuration that if set to false the emails will be sent synchronously
    mattr_accessor :enabled
    @@enabled = true

    # Allow configuring Devise::Async with a block
    #
    # Example:
    #
    #     UmengApi::Async.setup do |config|
    #       config.backend = :sidekiq
    #       config.queue   = :my_custom_queue
    #     end
    def self.setup
      yield self
    end
  end
end
