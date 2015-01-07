# encoding: utf-8
require 'net/http'
require 'uri'
require 'digest'
module UmengApi
  module Service
    module Helpers
      extend ActiveSupport::Concern

      #发送消息
      def send_message(params={})
        ArgumentError unless params.is_a?(Hash)
        params.reverse_merge!({
            appkey: UmengApi.appkey,
            timestamp: Time.now.to_i
        })
        p params
        request(:POST, 'api/send', params)
      end

      #任务状态查询
      #POST http://msg.umeng.com/api/status?sign=mysign
      def status(task_id)
        ArgumentError if task_id.nil?
        params = {
            appkey: UmengApi.appkey,
            timestamp: Time.now.to_i,
            task_id: task_id
        }
        request(:POST, 'api/status', params)
      end

      #取消任务
      #POST http://msg.umeng.com/api/cancel?sign=mysign
      def cancel(task_id)
        ArgumentError if task_id.nil?
        params = {
            appkey: UmengApi.appkey,
            timestamp: Time.now.to_i,
            task_id: task_id
        }
        request(:POST, 'api/cancel', params)
      end

      #上传文件
      #POST http://msg.umeng.com/upload?sign=mysign
      def upload(content)
        ArgumentError if content.nil?
        params = {
            appkey: UmengApi.appkey,
            timestamp: Time.now.to_i,
            content: content
        }
        request(:POST, 'upload', params)
      end

      private
      #生成签名
      def generate_sign(method, url, post_body)
        Digest::MD5.hexdigest([method, url, post_body, UmengApi.app_master_secret].join)
      end

      #发送请求
      def request(method = :POST, uri, post_body)
        url = [UmengApi.url, '/', uri]
        sign = generate_sign(method, url.join, post_body)
        p method, uri, url, post_body, sign
        res = Net::HTTP.post_form(URI.parse(url.concat(['?sign=', sign]).join), post_body)
        p 'response======>', res
        res
      end

    end
  end
end
