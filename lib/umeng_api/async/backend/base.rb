module UmengApi
  module Async
    module Backend
      class Base
        def self.enqueue(*args)
          raise NotImplementedError, "Any UmengApi::Async::Backend subclass should implement `self.enqueue`."
        end

        # Loads the resource record and sends the email.
        #
        # It uses `orm_adapter` API to fetch the record in order to enforce
        # compatibility among diferent ORMs.
        def perform(method, resource_class, resource_id, *args)
          resource = resource_class.constantize.to_adapter.get!(resource_id)
          args[-1] = args.last.symbolize_keys if args.last.is_a?(Hash)
          sender_class(resource).send(method, resource, *args)
        end

        private

        def sender_class(resource = nil)
          @sender_class || UmengApi.sender
        end
      end
    end
  end
end
