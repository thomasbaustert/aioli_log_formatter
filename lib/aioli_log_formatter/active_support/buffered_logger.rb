#
# ActiveSupport::BufferedLogger is the central logger class for all Rails loggers
# (e.g. ActiveRecord::Base.logger, ActionMailer::Base.logger, ActionController::Base.logger).
# Unfortunately it does not support setting a formatter so we have to monkey patch it.
#
module ActiveSupport
  class BufferedLogger

    private

      def open_logfile(log)
        logger = Logger.new log

        if AioliLogFormatter::Engine.config.aioli_log_formatter.enabled
          logger.formatter = AioliLogFormatter::Engine.config.aioli_log_formatter.formatter
        end

        logger
      end

  end
end
