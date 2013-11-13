##
# test/dummy/spec/spec_helper
#
ENV["RAILS_ENV"] ||= 'test'
require_relative '../config/environment'
require 'rspec/rails'
require 'timecop'
require_relative '../../../spec/support/context_helper'

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus


  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.include ContextHelper
end
