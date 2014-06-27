$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'data_forge'
require_relative 'support/helpers/record_reader_helper'
require_relative 'support/helpers/record_writer_helper'


RSpec.configure do |config|
  config.order = "random"
  config.raise_errors_for_deprecations!

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end

  config.include RSpec::Helpers::RecordReaderHelper
  config.include RSpec::Helpers::RecordWriterHelper
end
