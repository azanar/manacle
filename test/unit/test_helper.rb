$:.push('lib')

require 'coveralls'
Coveralls.wear!

if ENV["ENABLE_SIMPLE_COV"]
  require 'simplecov'
  SimpleCov.start do
    add_filter "test"
    add_group 'API',          "lib"
  end
end

require 'test/unit/testcase'
require "mocha/setup"

