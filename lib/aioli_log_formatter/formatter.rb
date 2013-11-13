require 'socket'

module AioliLogFormatter

  class Formatter

    # Rails 2
    def format(message)
      "#{timestamp} #{hostname} rails[#{process_id}] #{shorten_session_id} #{user_id}: #{sanitize(message)}\n"
    end

    # Rails 3
    def call(severity, timestamp, progname, message)
      format(message)
    end

    private

    def timestamp
      Time.now.strftime("%b %d %H:%M:%S")
    end

    def hostname
      @parsed_hostname ||= Socket.gethostname.split('.').first
    end

    def process_id
      $$
    end

    def shorten_session_id
      session_id[0,10]
    end

    # before_filter { |controller| ($session_id ||= {})[Thread.current] = controller.session_id || 0 }
    def session_id
      defined?($session_id) ? "#{$session_id[Thread.current] || 0}" : '0'
    end

    # before_filter { |controller| ($user_id ||= {})[Thread.current] = controller.session[:user_id] || 0 }
    def user_id
      defined?($user_id) ? "u#{$user_id[Thread.current] || 0}" : 'u0'
    end

    def sanitize(message)
      message.to_s.gsub(/\n/, ' ').lstrip
    end

  end
end
