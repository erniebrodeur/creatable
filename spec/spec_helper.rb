require 'bundler/setup'
require 'simplecov'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start do
  add_filter '/spec/'
end

require 'creatable'
