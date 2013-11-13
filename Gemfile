source 'https://rubygems.org'

# Specify your gem's dependencies in aioli_log_formatter.gemspec
gemspec

# Thanks to http://schneems.com/post/50991826838/testing-against-multiple-rails-versions
#
# export RAILS_VERSION=3.2.15; bundle update; bundle exec rake
# export RAILS_VERSION=4.0.1; bundle update; bundle exec rake
#
rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
when "master"
  {github: "rails/rails"}
when "default"
  ">= 3.2.0"
else
  "~> #{rails_version}"
end

gem "rails", rails

gem 'quiet_assets'