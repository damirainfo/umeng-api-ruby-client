module UmengApi
  module Async
    module Models
      extend ActiveSupport::Concern

      # included do
      #   # Register hook to send all devise pending messages.
      #   #
      #   # When supported by the ORM/database we send just after commit to
      #   # prevent the backend of trying to fetch the record and send the
      #   # message before the record is committed to the databse.
      #   #
      #   # Otherwise we use after_save.
      #   if respond_to?(:after_commit) # AR only
      #     after_commit :send_umeng_pending_messages
      #   else # mongoid
      #     after_save :send_umeng_pending_messages
      #   end
      # end

      protected

      # This method overwrites umeng's own `send_umeng_message`
      # to capture all email messages and enqueue it for background
      # processing instead of sending it inline as umeng api does by
      # default.
      def send_umeng_message(type, *args)
        p '====ASYNC===', type
        return super unless UmengApi::Async.enabled

        # If the record is dirty we keep pending messages to be enqueued
        # by the callback and avoid before commit job processing.
        if changed?
          umeng_pending_messages << [ type, args ]
          # If the record isn't dirty (aka has already been saved) enqueue right away
          # because the callback has already been triggered.
        else
          UmengApi::Async::Worker.enqueue(type, self.class.name, self.id.to_s, *args)
        end
      end

      # Send all pending messages.
      def send_umeng_pending_messages
        umeng_pending_messages.each do |type, args|
          # Use `id.to_s` to avoid problems with mongoid 2.4.X ids being serialized
          # wrong with YAJL.
          UmengApi::Async::Worker.enqueue(type, self.class.name, self.id.to_s, *args)
        end
        @umeng_pending_messages = []
      end

      def umeng_pending_messages
        @umeng_pending_messages ||= []
      end
    end
  end
end
