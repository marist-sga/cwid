require_relative '../lib/cwid'

require 'rspec'
require 'vcr'
require 'webmock/rspec'

RSpec.configure do |c|
  # c.extend VCR::RSpec::Macros

  c.before do
    CWID.configure do |conf|
      conf.username = 'foobar'
      conf.password = 'barfoo'
    end
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
end
