#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-22 01:32:34
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-23 20:48:48
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

module Gramm
  module ActsAsGrammer

    extend ActiveSupport::Concern
      included do
        has_many :inbox_gramms, -> { where(gramms: { recipient_trashed: false }).order('id DESC') }, :as => :recipient, :dependent => :destroy, :class_name => '::Gramm::Gramm'
        has_many :unread_gramms, -> { where(gramms: { is_read: false, recipient_trashed: false }).order('id DESC') }, :as => :recipient, :dependent => :destroy, :class_name => '::Gramm::Gramm'
        has_many :outbox_gramms, -> { where(gramms: { sender_trashed: false }).order('id DESC') }, :as => :sender, :dependent => :destroy, :class_name => '::Gramm::Gramm'
        has_many :all_rcvd_gramms, :as => :recipient, :dependent => :destroy, :class_name => '::Gramm::Gramm'
        has_many :all_sent_gramms, :as => :sender, :dependent => :destroy, :class_name => '::Gramm::Gramm'

        has_many :trashed_inbox_gramms, -> { where(gramms: { recipient_trashed: true }).order('id DESC') }, :as => :recipient, :dependent => :destroy, :class_name => '::Gramm::Gramm'
        has_many :trashed_outbox_gramms, -> { where(gramms: { sender_trashed: true }).order('id DESC') }, :as => :sender, :dependent => :destroy, :class_name => '::Gramm::Gramm'
      end

    # Send a gramm to a recip
    def send_gramm(recipient, subject, body, thread_id=nil)
      if recipient && is_grammer?(recipient)
        Gramm.create( :sender => self, :recipient => recipient, :subject => subject, :body => body, :thread_id => thread_id )
      else
        nil
      end
    end

    # Test if an actor (usually a recipient) is also ActsAsGrammer
    def is_grammer?(actor)
      actor.class.included_modules.include?(ActsAsGrammer)
    end

    # List of all trashed gramms
    def trashed_gramms
      #(self.trashed_inbox_gramms + self.trashed_outbox_gramms).sort { |x,y| y.id <=> x.id }
       Gramm.where(sender: self, sender_trashed: true, sender_deleted: false).or(Gramm.where(recip: self, recip_trashed: true, recip_deleted: false)).order('id DESC')
    end

    # Find the gramm for the current actor
    def find_gramm(id)
      self.all_rcvd_gramms.find_by_id(id) || self.all_sent_gramms.find_by_id(id)
    end


  end # module ActsAsGrammer
end # module Gramm
