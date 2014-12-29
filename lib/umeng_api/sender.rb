class UmengApi::Sender
  class << self
    include UmengApi::Service::Helpers

    # def to (record, service, opts={})
    #   opts.merge!({type: service.to_s.downcase})
    #   UmengApi::Service.const_get("#{service.to_s.capitalize}").send(:to, options_wrapper(opts))
    # end

    def send_broadcast_message(record, opts={})
      p record, opts
      send_message(opts)
    end

    def send_groupcast_message(record, opts={})
      send_message(opts)
    end

    def send_unicast_message(record, opts={})
      send_message(opts)
    end
  end
end