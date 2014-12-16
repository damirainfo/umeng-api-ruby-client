# desc "Explaining what the task does"
# task :umeng_api do
#   # Task goes here
# end
namespace :umengapi do
    task :setup do 
        UmengApi.setup do |config|
            config.url = 'www.baidu.com'
        end
        UmengApi.send
    end
end