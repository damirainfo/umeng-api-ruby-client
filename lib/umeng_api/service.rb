# encoding: utf-8
require "umeng_api/version"
require 'net/http'
require 'digest'

module UmengApi

  module Service
    autoload :Helpers,      "umeng_api/service/helpers"

    mattr_accessor :url
    @@url = %q(http://msg.umeng.com/api/send)

    mattr_accessor :appkey

    mattr_accessor :app_master_secret

    def self.setup
      yield self
    end

    class Getter
      def initialize name
        @name = name
      end

      def get
        ActiveSupport::Dependencies.constantize(@name)
      end
    end

    def self.ref(arg)
      if defined?(ActiveSupport::Dependencies::ClassCache)
        ActiveSupport::Dependencies::reference(arg)
        Getter.new(arg)
      else
        ActiveSupport::Dependencies.ref(arg)
      end
    end

    # Get the sender class from the sender reference object.
    def self.sender
      @@sender_ref.get
    end

    # Set the sender reference object to access the sender.
    def self.sender=(class_name)
      @@sender_ref = ref(class_name)
    end
    self.sender = "UmengApi::Sender"

    #validation_token为appkey, app_master_secret与timestamp的MD5码
    def self.generate_validation_token(timestamp)
      Digest::MD5.hexdigest([@@appkey, @@app_master_secret, timestamp].join)
    end
  end
end

require 'umeng_api/models'
require 'umeng_api/sender'
