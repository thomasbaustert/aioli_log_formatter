# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aioli_log_formatter/version'

Gem::Specification.new do |gem|
  gem.name          = "aioli_log_formatter"
  gem.version       = AioliLogFormatter::VERSION
  gem.authors       = ["Thomas Baustert"]
  gem.email         = ["business@thomasbaustert.de"]
  gem.description   = %q{Logging formatter for Rails}
  gem.summary       = %q{Aioli logger (All In One LIne Logger) is a logging formatter for Rails}
  gem.homepage      = "https://github.com/thomasbaustert/aioli_log_formatter"
  gem.license       = 'MIT'
  gem.files         = Dir["{lib}/**/*"] + ["MIT-LICENSE", "README.md"]
  gem.test_files    = gem.files.grep(%r{^(test|spec)/})
  gem.require_paths = ["lib"]

  #gem.add_dependency 'rails'

  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'timecop'
  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
end
