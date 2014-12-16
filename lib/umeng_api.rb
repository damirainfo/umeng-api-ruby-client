# encoding: utf-8
require "umeng_api/version"

module UmengApi

    module Service
      autoload :Base,         "umeng_api/service/base"
      autoload :Broadcast,       "umeng_api/service/broadcast"
      autoload :Groupcast,       "umeng_api/service/groupcast"
      autoload :Unicast,       "umeng_api/service/unicast"
    end

    mattr_accessor :url
    @@url = %q(http://msg.umeng.com/api/send)

    mattr_accessor :appkey
    #Default value
    #@@app_master_secret = 'xxxx'

    mattr_accessor :app_master_secret

    def self.setup
        yield self
    end

    def self.send
        p @@url
    end

end
