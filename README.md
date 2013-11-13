# Aioli Logging Formatter

Aioli logger (All In One LIne Logger) is a logging formatter for Rails 3.

Aioli make our meals delicious, right?

By default it logs lines of format:

    <date> <host> rails[<processId>] <sessionId> u<userId>>: <message>

Examples:

    Nov 23 14:27:56 host rails[19572] f79a2d8633 u18: Completed in 1218ms (View: 772, DB: 209) | 200 OK [http://localhost/claims]
    Nov 23 14:27:56 host rails[19572] 0 u0: Completed in 1218ms (View: 772, DB: 209) | 200 OK [http://localhost/claims]

## Installation

Add this line to your application's Gemfile:

    gem 'aioli_log_formatter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aioli_log_formatter

## Usage

Enable the formatter:

    # config/application.rb
    ...
      class Application < Rails::Application
        ...
        config.aioli_log_formatter.enabled = true


Enable before filters to retrieve session ID and user ID from default sources.

    class ApplicationController < ActionController::Base

      aioli_log_formatter
      ...
    end

This is the same as:

    class ApplicationController < ActionController::Base

      aioli_log_formatter user_id: lambda { |controller| controller.session[:user_id] },
                       session_id: lambda { |controller| controller.request.session_options[:id] }
      ...
    end

To get the values from different sources simply change the procs, e.g.:

    class ApplicationController < ActionController::Base

      aioli_log_formatter user_id: lambda { |controller| controller.session[:account_id] }
      ...
    end

When using [Devise](https://github.com/plataformatec/devise) gem you can get the user ID as follows:

    class ApplicationController < ActionController::Base

      aioli_log_formatter user_id: lambda { |controller|
        user = controller.env['warden'].user
        user ? user.id : nil
      }
      ...
    end

## Define your own Formatter

Define your formatter by inheriting from `AioliLogFormatter::Formatter` for example:

    class MyAwesomeFormatter < AioliLogFormatter::Formatter

      # I like different formatting
      def call(severity, timestamp, progname, message)
        "#{timestamp} #{hostname} pid=#{process_id} sid=#{shorten_session_id} uid=#{user_id} msg=#{sanitize(message)}\n"
      end

    end

Have a look into source code of `AioliLogFormatter::Formatter` for more methods to overwrite.

Enable the formatter:

    # config/application.rb
    require_relative "../path/to/my_awesome_formatter"

    ...
      class Application < Rails::Application
        ...
        config.aioli_log_formatter.enabled = true
        config.aioli_log_formatter.formatter = MyAwesomeFormatter.new


See new formatting:

    2013-11-12 16:16:50 +0100 host pid=69402 sid=e36db0f022 uid=u42 msg=Started GET "/...

## Tests

Examples are located under `spec` and `test/dummy/spec` and are executed via:

    $ cd path/to/aioli_log_formatter
    $ bundle exec rake spec


## Credits

Inspired by [logjam_logger](https://github.com/alpinegizmo/logjam_logger)

## License

Copyright © 2013 [Thomas Baustert](http://thomasbaustert.de), released under the MIT license
