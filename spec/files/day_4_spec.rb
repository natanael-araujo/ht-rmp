# -*- encoding: utf-8 -*-
require "spec_helper"

describe "Exercises: Day 4" do
  context "Exercise #1" do
    it "should set constant" do
      set_constant(:my_awesome_constant, "Ruby Metaprogramming")
      Object.constants.should include(:MY_AWESOME_CONSTANT)
      ::MY_AWESOME_CONSTANT.should == "Ruby Metaprogramming"
    end

    it "should return false when constant is already set" do
      set_constant(:my_awesome_constant, 1)
      set_constant(:my_awesome_constant, 1).should be_false
    end

    it "should override existing constant" do
      set_constant(:my_awesome_constant, 1)
      set_constant(:my_awesome_constant, 2)
      ::MY_AWESOME_CONSTANT.should == 2
    end
  end

  context "Exercise #2" do
    it "should set constant" do
      Object.constants.should include(:Color)
    end

    it "should respond to color methods" do
      Color.should respond_to(:red)
      Color.should respond_to(:green)
      Color.should respond_to(:blue)
      Color.should respond_to(:black)
      Color.should respond_to(:white)
      Color.should_not respond_to(:orange)
    end

    it "should return color" do
      Color.red.should == "ff0000"
      Color.green.should == "00ff00"
      Color.blue.should == "0000ff"
    end

    it "should raise when an invalid color is provided" do
      expect { Color.orange }.to raise_error(NoMethodError)
    end
  end

  context "Exercise #3" do
    it "should set constant" do
      Object.constants.should include(:Monster)
    end

    it "should track monsters" do
      class Zombie < Monster; end
      class Frankenstein < Monster; end

      Monster.ugly_monsters.should include("Zombie")
      Monster.ugly_monsters.should include("Frankenstein")
    end
  end

  context "Exercise #4" do
    it "should set exception" do
      Monster.constants.should include(:NoBadWordsError)
    end

    it "should raise exception" do
      expect {
        Monster.class_eval do
          def fuck_you; end
        end
      }.to raise_error(Monster::NoBadWordsError)
    end
  end

  context "Exercise #5" do
    subject {
      Car.new do
        name "Boxster"
        brand "Porsche"
        rpm 6250
        speed 266
      end
    }

    it "should set constant" do
      Object.constants.should include(:Car)
    end

    it "should set attributes" do
      subject.name.should == "Boxster"
      subject.brand.should == "Porsche"
      subject.rpm.should == 6250
      subject.speed.should == 266
    end

    it "should add attribute on demand" do
      subject.should_not respond_to(:type)
      subject.type "Roadster"
      subject.should respond_to(:type)
      subject.type.should == "Roadster"
    end

    it "should add attribute on demand when using writer" do
      subject.should_not respond_to(:doors)
      subject.doors = 2
      subject.should respond_to(:doors)
      subject.doors.should == 2
    end
  end
end
