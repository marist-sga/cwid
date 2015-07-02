require_relative '../lib/cwid'

require 'rspec'
require 'vcr'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before do
    configure_cwid!
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
end

def configure_cwid!
  CWID.configure do |config|
    config.username = 'foobar'
    config.password = 'barfoo'
  end
end
