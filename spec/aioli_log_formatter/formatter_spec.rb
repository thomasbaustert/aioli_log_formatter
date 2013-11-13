require 'spec_helper'
require 'socket'
require_relative '../../lib/aioli_log_formatter'

module AioliLogFormatter
  describe Formatter do

    describe "#format" do
      before do
        set_user_id(nil)
        set_session_id(nil)
        Socket.stub(:gethostname).and_return("host42")
        Timecop.freeze("2013-06-25 12:13:14")
      end

      after do
        Timecop.return
      end

      context "no data given" do
        it "writes default log line" do
          subject.format("a message").should == "Jun 25 12:13:14 host42 rails[#{$$}] 0 u0: a message\n"
        end
      end

      context "session given" do
        it "writes shorten id for session" do
          set_session_id("1234567890skipped")
          subject.format("a message").should == "Jun 25 12:13:14 host42 rails[#{$$}] 1234567890 u0: a message\n"
        end
      end

      context "user given" do
        it "writes uID for user" do
          set_user_id("2815")
          subject.format("a message").should == "Jun 25 12:13:14 host42 rails[#{$$}] 0 u2815: a message\n"
        end
      end

      context "hostname given" do
        it "writes hostname" do
          Socket.stub(:gethostname).and_return("host4711")
          subject.format("a message").should == "Jun 25 12:13:14 host4711 rails[#{$$}] 0 u0: a message\n"
        end
      end

      it "sanitizes message" do
        subject.format(" a\nmessage\nwith\nlines ").should == "Jun 25 12:13:14 host42 rails[#{$$}] 0 u0: a message with lines \n"
      end
    end

  end
end
