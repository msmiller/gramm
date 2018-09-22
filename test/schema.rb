#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-22 00:21:40
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-22 00:54:31
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :name

    t.timestamps
  end

  create_table :gramms, :force => true do |t|
    t.references :sender, polymorphic: { null: false }
    t.references :recipient, polymorphic: { null: false }
    t.string :subject
    t.text :body
    t.integer :thread_id
    t.boolean :is_read, :default => false
    t.boolean :sender_trashed, :default => false
    t.boolean :recip_trashed, :default => false
    t.boolean :sender_deleted, :default => false
    t.boolean :recip_deleted, :default => false
    
    t.timestamps
  end




end
