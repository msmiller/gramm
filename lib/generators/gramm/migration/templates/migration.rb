#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-19 23:35:09
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-19 23:45:12
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

class GrammMigration < Unread::MIGRATION_BASE_CLASS
  def self.up
    create_table Gramm, force: true, options: create_options do |t|

      t.references :sender, polymorphic: { null: false }
      t.references :recip, polymorphic: { null: false }
      t.string :subject
      t.text :body
      t.integer :thread_id      # The first message of a thread
      t.integer :parent_id
      t.boolean :is_read, :default => false
      t.boolean :sender_trashed, :default => false
      t.boolean :recip_trashed, :default => false
      t.boolean :sender_deleted, :default => false
      t.boolean :recip_deleted, :default => false
      t.timestamps
    end

    add_index Gramm, "thread_id"
    add_index Gramm, "parent_id"
  end

  def self.down
    drop_table Gramm
  end

  def self.create_options
    options = ''
    if defined?(ActiveRecord::ConnectionAdapters::Mysql2Adapter) \
      && ActiveRecord::Base.connection.instance_of?(ActiveRecord::ConnectionAdapters::Mysql2Adapter)
      options = 'DEFAULT CHARSET=latin1'
    end
    options
  end
end