require 'aioli_log_formatter/version'
require 'aioli_log_formatter/formatter'
require 'aioli_log_formatter/engine'
require 'aioli_log_formatter/active_support/buffered_logger'
require 'aioli_log_formatter/controller/extension'

module AioliLogFormatter

  def self.setup
    ActionController::Base.send(:include, AioliLogFormatter::Controller::Extension)
  end

end
