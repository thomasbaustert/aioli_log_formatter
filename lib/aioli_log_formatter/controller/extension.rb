module AioliLogFormatter
  module Controller

    module Extension
      def self.included(base)
        base.class_eval do
          include InstanceMethods
          extend ClassMethods
        end
      end

      module InstanceMethods
      end

      module ClassMethods
        SESSION_ID_PROC = lambda { |controller| controller.request.session_options[:id] }
        USER_ID_PROC = lambda { |controller| controller.session[:user_id] }

        def aioli_log_formatter(options = {})
          return unless Rails.application.config.aioli_log_formatter.enabled

          if session_id = options.fetch(:session_id, SESSION_ID_PROC)
            before_filter { |controller| ($session_id ||= {})[Thread.current] = session_id.call(controller) || 0 }
          end

          if user_id = options.fetch(:user_id, USER_ID_PROC)
            before_filter { |controller| ($user_id ||= {})[Thread.current] = user_id.call(controller) || 0 }
          end

        end
      end
    end

  end
end
