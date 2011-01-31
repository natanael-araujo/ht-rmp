# -*- encoding: utf-8 -*-
require "test_helper"

class TestDayOne < Test::Unit::TestCase
  class Dummy; end

  def test_exercise_1
    klass = Class.new
    assert_same klass.singleton_class, klass.metaclass
  end

  def test_exercise_2
    assert_respond_to App, :name
    assert_respond_to App, :name=

    expected = "HOWTO Ruby Metaprogramming"
    App.name = expected

    assert_same Module, App.class
    assert_equal expected, App.name
    assert App.instance_variables.include?(:"@name")
  end

  def test_exercise_3
    assert Object.constants.include?(:Person), "Você precisa definir a classe Person"

    klass = new_class
    assert_same Person, klass.superclass
  end

  def test_exercise_4
    assert Object.constants.include?(:Awesome), "Você precisa definir a classe Awesome"
    assert_equal "Awesome", Awesome.name
  end

  def test_exercise_5
    object = TestDayOne::Dummy.new
    new_method(object)

    assert_respond_to object, :hello
    assert_equal "Hello from TestDayOne::Dummy instance", object.hello
  end
end
