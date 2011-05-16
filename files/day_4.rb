# encoding: UTF-8
require "spec_helper"

#1
def set_constant(name, value)
  name = name.to_s.upcase.gsub(/[^A-Z0-9]/, "_")
  if Object.const_defined? name
    Object.const_get(name) == value ? (return false) : Object.instance_eval {remove_const(name)}
  end
  Object.const_set(name, value)
end

#2
module Color
  class << self
    COLORS = {
      :red => "ff0000",
      :blue => "0000ff",
      :green => "00ff00",
      :black => "000000",
      :white => "ffffff"
    }

    def method_missing(method, *args)
      return COLORS[method] if COLORS.key? method
      super
    end

    def respond_to?(method, include_private = false)
      return true if COLORS.key? method.to_sym
      super
    end
  end
end

#3
class Monster
  @ugly_monsters = []

  def self.inherited(child)
    @ugly_monsters << child.name unless @ugly_monsters.include? child.name
  end
  
  def self.ugly_monsters
    @ugly_monsters
  end
end

#4
class Monster
  class NoBadWordsError < StandardError; end

  def self.method_added(method)
    raise NoBadWordsError, "Method name should not include a bad word" if method.to_s.include? "fuck"
  end
end

#5
class Car
  def initialize(&block)
    instance_eval(&block) if block_given?
    self
  end

  def method_missing(method, *args)
    method = method.to_s.chop! if method.to_s.end_with? "="
    instance_eval <<-RUBY, __FILE__, __LINE__
      if args.any?
        @#{method} = args.first
        def #{method}
          @#{method}
        end
      else
        super
      end
    RUBY
  end
end
