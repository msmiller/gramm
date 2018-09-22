#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-22 00:43:16
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-22 02:09:39
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

include Gramm::ActsAsGrammer

class User < ActiveRecord::Base

  #has_many :gramms, as: :sender, class_name: '::Gramm::Gramm'
  #has_many :gramms, as: :recipientient, class_name: '::Gramm::Gramm'

  #has_many :inbox_gramms, -> { where(gramms: { recipient_trashed: false }).order('id DESC') }, :as => :recipient, :dependent => :destroy, :class_name => '::Gramm::Gramm'
  #has_many :unread_gramms, -> { where(gramms: { is_read: false, recipient_trashed: false }).order('id DESC') }, :as => :recipient, :dependent => :destroy, :class_name => '::Gramm::Gramm'
  #has_many :outbox_gramms, -> { where(gramms: { sender_trashed: false }).order('id DESC') }, :as => :sender, :dependent => :destroy, :class_name => '::Gramm::Gramm'
  #has_many :all_rcvd_gramms, :as => :recipient, :dependent => :destroy, :class_name => '::Gramm::Gramm'
  #has_many :all_sent_gramms, :as => :sender, :dependent => :destroy, :class_name => '::Gramm::Gramm'

  #has_many :trashed_inbox_gramms, -> { where(gramms: { recipient_trashed: true }).order('id DESC') }, :as => :recipient, :dependent => :destroy, :class_name => '::Gramm::Gramm'
  #has_many :trashed_outbox_gramms, -> { where(gramms: { sender_trashed: true }).order('id DESC') }, :as => :sender, :dependent => :destroy, :class_name => '::Gramm::Gramm'

  acts_as_grammer
end
