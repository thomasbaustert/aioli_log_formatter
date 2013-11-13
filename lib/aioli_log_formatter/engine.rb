module AioliLogFormatter
  class Engine < ::Rails::Engine
    config.aioli_log_formatter = ActiveSupport::OrderedOptions.new
    config.aioli_log_formatter.enabled = false
    config.aioli_log_formatter.formatter = Formatter.new

    initializer :aioli_log_formatter do |app|
      AioliLogFormatter.setup(app) if app.config.aioli_log_formatter.enabled
    end
  end
end
