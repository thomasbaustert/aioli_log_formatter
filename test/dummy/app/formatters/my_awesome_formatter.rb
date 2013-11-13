class MyAwesomeFormatter < AioliLogFormatter::Formatter

  # I like different formatting
  def call(severity, timestamp, progname, message)
    "#{timestamp} #{hostname} pid=#{process_id}] sid=#{shorten_session_id} uid=#{user_id} msg=#{sanitize(message)}\n"
  end

end
