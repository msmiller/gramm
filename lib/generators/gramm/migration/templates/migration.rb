#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-19 23:35:09
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-22 01:19:21
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

class GrammMigration < (ActiveRecord.version.release() < Gem::Version.new('5.2.0') ? ActiveRecord::Migration : ActiveRecord::Migration[5.2])
  def self.up
    create_table Gramm, force: true, options: create_options do |t|

      t.references  :sender, polymorphic: { null: false }
      t.references  :recipient, polymorphic: { null: false }
      t.string      :subject
      t.text        :body
      t.string      :format, default: 'text'
      t.boolean     :is_read, :default => false

      t.integer     :thread_id # The first message of a thread
      t.boolean     :allow_replies, :default => false # Change to true if you want replies on by default

      t.boolean     :sender_trashed, :default => false
      t.boolean     :recipient_trashed, :default => false
      t.boolean     :sender_deleted, :default => false
      t.boolean     :recipient_deleted, :default => false

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
