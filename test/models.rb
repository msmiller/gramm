#!/usr/bin/ruby
# @Author: Mark Miller
# @Date:   2018-09-22 00:43:16
# @Last Modified by:   Mark Miller
# @Last Modified time: 2018-09-23 20:52:58
#
# Copyright (c) 2017-2018 Sharp Stone Codewerks / Mark S. Miller


class User < ActiveRecord::Base
  include Gramm::ActsAsGrammer
end
