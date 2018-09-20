require "gramm/railtie"

module Gramm
  # Your code goes here...
end

ActiveRecord::Base.send :include, Gramm

Gramm::MIGRATION_BASE_CLASS = if ActiveRecord::VERSION::MAJOR >= 5
  ActiveRecord::Migration[5.0]
else
  ActiveRecord::Migration
end
