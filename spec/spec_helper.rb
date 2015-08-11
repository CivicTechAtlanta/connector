require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.default_cassette_options  = { :record => :once }
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
end
