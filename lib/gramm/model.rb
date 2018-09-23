#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-22 02:13:30
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-22 03:28:30
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

module Gramm

  class Gramm < ::ActiveRecord::Base

    self.table_name = 'gramms'

    belongs_to :sender, :polymorphic => true
    belongs_to :recipient, :polymorphic => true
    has_many   :replies, class_name: 'Gramm', foreign_key: :thread_id, primary_key: :id, dependent: :destroy
    scope      :threads, -> { where( thread_id: nil ) }
    
    BOXNAMES = {
      'inbox' => 'Inbox',
      'sentbox' => 'Sent',
      'trash' => 'Trash'
    }

    # set/unset the is_read flag - only recipientient does this
    def mark_as_read
      self.update_attribute :is_read, true
      self.is_read
    end

    def mark_as_unread
      self.update_attribute :is_read, false
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

    # Reply to a Gramm
    def reply_to(reply_sender, body)
      Gramm.create( :sender => reply_sender,
                    :recipient => (reply_sender == self.sender ? self.recipient : self.sender),
                    :subject => self.subject, :body => body, :thread_id => self.id )
    end

    # Thread support methods

    def thread
      self.replies.order('id DESC')
    end

    def thread_has_unread?
      self.replies.where(is_read: false).count >= 1
    end

  end # class Gramm

end # module Gramm
