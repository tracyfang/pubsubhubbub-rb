require File.dirname(__FILE__) + '/test_helper'
#require "test_helper"

require "webrat"
require "rack/test"
require "stories"
require "stories/runner"

Webrat.configure do |config|
  config.mode = :rack
end

class Test::Unit::TestCase
  include Webrat::Methods
  include Webrat::Matchers
  include Stories::Webrat
end
