#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-22 02:13:30
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-22 02:39:17
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

module Gramm

  class Gramm < ::ActiveRecord::Base

    self.table_name = 'gramms'

    belongs_to :sender, :polymorphic => true
    belongs_to :recipient, :polymorphic => true

    BOXNAMES = {
      'inbox' => 'Inbox',
      'sentbox' => 'Sent',
      'trash' => 'Trash'
    }

    # set the is_read flag - only recipientient does this
    def mark_as_read
      self.update_attribute :is_read, true
      self.is_read
    end

    # Toggle the is_trashed flag
    def mark_as_trashed(actor)
      if self.was_sent_by?(actor)
        self.update_attribute :sender_trashed, !self.sender_trashed
        self.sender_trashed
      else
        self.update_attribute :recipient_trashed, !self.recipient_trashed
        self.recipient_trashed
      end
    end

    # Set the is_deleted flag
    def mark_as_deleted(actor)
      if self.was_sent_by?(actor)
        self.update_attribute :sender_deleted, true
        self.sender_deleted
      else
        self.update_attribute :recipient_deleted, true
        self.recipient_deleted
      end
    end

    # Was this sent by the actor?
    def was_sent_by?(actor)
      (self.sender.class == actor.class) && (self.sender.id == actor.id)
    end

  end # class Gramm

end # module Gramm