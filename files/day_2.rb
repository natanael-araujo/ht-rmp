# encoding: UTF-8
require "spec_helper"

#1
def send_message
  Message.new.send(:deliver)
end

#2
def send_message_with_args
  Message.__send__(:send, Message.new, 2)
end

#3
def send_private_method
  Message.new.send(:prepare)
end

#4
def send_public_method
  Message.new.prepare
end

#5 refatorar
class Song

  attr_accessor :title, :artist, :duration
  def initialize(hash)
    # [:title, :artist, :duration].each {|attr| self.send(attr.to_s+"=", hash.fetch(attr))}
    # ?
    ['title=', 'artist=', 'duration='].each {|attr| self.send(attr, hash.fetch(attr.chop.to_sym))}
  end
end

#6
class String
  def to_leet
    self.gsub(/[aeiou]/, { 'a' => '4', 'e' => '3', 'i' => '1', 'o' => '0', 'u' => "μ"})
  end
end

#7
class Object
  def self.leet_attr(*attrs)
    attrs.each do |attr|
      attr_accessor attr

      define_method(attr.to_s.to_leet) do
        send(attr).to_s.to_leet
      end
    end
  end
end

#8
class Object
  def self.reverse_attr(*attrs)
    attrs.each do |attr|
      attr_accessor attr

      define_method(attr.to_s.reverse) do
        send(attr).to_s.reverse
      end
    end
  end
end

#9
class << Car; remove_method :useless; end

#10
Ferrari.class_eval { remove_method :color }

#11
Ferrari.class_eval { undef_method :engine }

#12

module Calc
  sum = instance_method :sum
  
  define_method :sum do |n1, n2|
    sum.bind(self).call(n1 ||= 0, n2 ||= 0)
  end
end
