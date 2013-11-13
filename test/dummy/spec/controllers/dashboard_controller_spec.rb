require_relative '../spec_helper'

describe DashboardController do

  # Cause before filters are defined in the controller class (not instance)
  # we have to make a new controller class for each example. Otherwise filters
  # of one example will be active in another.
  def self.make_controller
    controller do
      def index
        logger.info "an info message"
      end
    end
  end

  let(:log_device) { StringIO.new }

  before do
    # Let logger write to log_device to have access in examples
    test_logger = Logger.new(log_device)
    test_logger.formatter = AioliLogFormatter::Formatter.new
    controller.logger.instance_variable_set(:@logger, test_logger)

    reset_user_id
    reset_session_id
    Socket.stub(:gethostname).and_return("host101")
    Timecop.freeze("2013-12-24 23:59:00")
  end

  after do
    Timecop.return
  end

  describe "::aioli_log_formatter" do
    context "no options given" do
      make_controller

      it "use default" do
        controller.class.send(:aioli_log_formatter)
        short_session_id = controller.request.session_options[:id][0,10]

        get :index

        message_line.should == "Dec 24 23:59:00 host101 rails[#{$$}] #{short_session_id} u0: an info message"
      end
    end

    context "session_id proc given" do
      make_controller

      it "get session id from proc" do
        controller.class.send(:aioli_log_formatter, session_id: lambda { |controller| "sess42" }, user_id: nil)

        get :index

        message_line.should == "Dec 24 23:59:00 host101 rails[#{$$}] sess42 u0: an info message"
      end
    end

    context "user_id proc given" do
      make_controller

      it "get user_id from proc" do
        controller.class.send(:aioli_log_formatter, session_id: nil, user_id: lambda { |controller| "9988" })

        get :index

        message_line.should == "Dec 24 23:59:00 host101 rails[#{$$}] 0 u9988: an info message"
      end
    end

    private

    def message_line
      log_device.string.scan(/^.*an info message.*$/).first
    end

  end

end