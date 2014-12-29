module UmengApi
  module Async
    module Backend
      # Gives the desired backend driver class to be used to enqueue
      # jobs.
      def self.for(backend)
        const_get(backend.to_s.camelize)
      rescue NameError
        raise ArgumentError, "unsupported backend for umeng_api-async."
      end
    end
  end
end
