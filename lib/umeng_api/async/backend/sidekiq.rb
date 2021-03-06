module UmengApi
  module Async
    module Backend
      class Sidekiq < Base
        include ::Sidekiq::Worker

        sidekiq_options :queue => UmengApi::Async.queue

        def self.enqueue(*args)
          perform_async(*args)
        end
      end
    end
  end
end
