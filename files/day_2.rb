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
    [:title, :artist, :duration].each {|attr| self.send(attr.to_s+"=", hash.fetch(attr))}
  end
end

#6