class DashboardController < ApplicationController

  if Rails.env.development?
    #aioli_log_formatter user_id: lambda { |controller| 42 }
    aioli_log_formatter

    def index
    end
  end

end
