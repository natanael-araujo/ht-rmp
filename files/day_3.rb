# encoding: UTF-8
require "spec_helper"

#1
module Helper
  class_eval <<-RUBY, __FILE__, __LINE__
    def upcase(str)
      str.upcase
    end
  RUBY
end

#2
def extend_object(object, mod)
  object.extend mod
end

#3
Helper.class_eval do
  def self.downcase(string)
    string.downcase
  end
end

#4
def execute_block(object, block)
  object.instance_eval(&block)
end

#5
def execute_private
  Tools.class_eval { prepare }
end

#6
module Multiplier
  def multiply(multiplier)
    self.map {|item| item * multiplier}
  end
end
