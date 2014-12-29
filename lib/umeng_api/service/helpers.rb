module UmengApi
  module Service
    module Helpers
      extend ActiveSupport::Concern

      def send_message(opts)

      end

      private
      def options_wrapper(opts = {})
        timestamp = opts[:timestamp] || Time.now.to_i
        defaults = {
            appkey: UmengApi.appkey,
            timestamp: timestamp,
            # app_master_secret: UmengApi.app_master_secret,
            validation_token: UmengApi.generate_validation_token(timestamp)
        }
        opts.reverse_merge!(defaults)
      end

      def _post(opts)
        p opts
        res = Net::HTTP.post_form(URI.parse(UmengApi.url), opts)
        p res
      end

    end
  end
end
