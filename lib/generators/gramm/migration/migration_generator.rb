#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-19 23:33:53
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-21 00:47:03
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

require 'rails/generators'
require 'rails/generators/migration'

module Gramm
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc "Generates migration for gramms"
    source_root File.expand_path('../templates', __FILE__)

    def create_migration_file
      migration_template 'migration.rb', 'db/migrate/gramm_migration.rb'
    end

    def self.next_migration_number(dirname)
      #if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      #else
      #  "%.3d" % (current_migration_number(dirname) + 1)
      #end
    end
  end
end
