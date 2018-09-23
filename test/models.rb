#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-22 00:43:16
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-22 02:09:39
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller

include Gramm::ActsAsGrammer

class User < ActiveRecord::Base
  acts_as_grammer
end
