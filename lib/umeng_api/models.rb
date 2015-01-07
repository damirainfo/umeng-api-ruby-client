module UmengApi
  module Models
    extend ActiveSupport::Concern

    protected

    def send_umeng_message(type, *args)
      p '====DIRECT===', type, args
      UmengApi.sender.send(type, self, *args)
    end

  end
end