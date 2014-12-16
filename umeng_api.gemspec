# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "umeng_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "umeng_api"
  s.version     = UmengApi::VERSION
  s.authors     = ["xjoy"]
  s.email       = ["qiuxiaoj@gmail.com"]
  s.homepage    = "https://github.com/damirainfo/umeng-api-ruby-client"
  s.summary     = %q(umeng api ruby client)
  s.description = %q(umeng api ruby client)
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files   = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.2"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "webmock"
end
