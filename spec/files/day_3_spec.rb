# -*- encoding: utf-8 -*-
require "spec_helper"

describe "Exercises: Day 3" do
  context "Exercise #1" do
    subject { Object.new.extend(::Helper) }

    it "should set constant" do
      Object.constants.should include(:Helper)
    end

    it "should define method" do
      Helper.instance_methods.should include(:upcase)
    end

    it "should return uppercased strings" do
      subject.upcase("abc").should == "ABC"
    end

    it "should return method info" do
      method = subject.method(:upcase)
      file, line = method.source_location

      file.should match(/\/files\/day_3.rb$/)
      line.should be_kind_of(Fixnum)
    end
  end

  context "Exercise #2" do
    it "should extend object" do
      mod = Module.new { def hello; end }
      obj = Object.new

      extend_object(obj, mod).should respond_to(:hello)
    end
  end

  context "Exercise #3" do
    it "should define method" do
      Helper.methods.should include(:downcase)
    end

    it "should return downcased strings" do
      Helper.downcase("ABC").should == "abc"
    end
  end

  context "Exercise #4" do
    it "should execute block" do
      obj = Object.new
      block = proc { def hello; end }

      execute_block(obj, block)
      obj.should respond_to(:hello)
    end
  end

  context "Exercise #5" do
    it "should not execute send" do
      Tools.expects(:prepare).once
      Tools.expects(:send).never
      Tools.expects(:__send__).never

      execute_private
    end

    it "should execute private method" do
      obj = Object.new
      block = proc { def hello; end }

      execute_block(obj, block)
      obj.should respond_to(:hello)
    end
  end

  context "Exercise #6" do
    it "should define module" do
      Object.constants.should include(:Multiplier)
    end

    it "should multiply numbers" do
      numbers = [1,2,3]
      numbers.extend(Multiplier)

      numbers.multiply(2).should == [2,4,6]
    end
  end
end
