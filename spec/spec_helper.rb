$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'data_forge'

RSpec.configure do |config|
  config.order = "random"
  config.raise_errors_for_deprecations!

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
