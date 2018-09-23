# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

#require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
#ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
require "rails"
require "rails/test_help"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

Rails::TestUnitReporter.executable = 'bin/test'

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end

### module GeneratorTestHelpers
###
###   def generate_sample_app
###     system "rails new dummy --skip-active-record --skip-test-unit --skip-spring --skip-bundle"
###   end
###
###   def remove_sample_app
###     system "rm -rf dummy"
###   end
###
### end

### rails new dummy --skip-active-record --skip-test-unit --skip-spring --skip-bundle

require 'active_record'
require 'active_support'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load File.dirname(__FILE__) + '/schema.rb'
require File.dirname(__FILE__) + '/models.rb'

def print_and_flush(str)
  print str
  $stdout.flush
end

=begin
# https://github.com/seattlerb/minitest/issues/732
class Minitest::Result
  def method name
    o = Object.new
    def o.source_location
      ["unknown", -1]
    end
  end
end
=end

class Minitest::Result
  def method name
    o = Object.new
    def o.source_location
      ["unknown", -1]
    end
  end
end

def method name
  if name.to_sym == method_object.name
    method_object
  else
    orig_method(name)
  end
end
