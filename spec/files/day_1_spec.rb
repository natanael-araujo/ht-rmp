require "spec_helper"

describe "Exercises: Day 1" do
  context "Exercise #1" do
    it "should define Object#metaclass" do
      Object.should respond_to(:metaclass)
    end

    it "should not call singleton_class method" do
      klass = Class.new
      klass.expects(:singleton_class).never
      klass.metaclass
    end

    it "should return the singleton class" do
      klass = Class.new
      klass.singleton_class.should be(klass.metaclass)
    end
  end

  context "Exercise #2" do
    it "should define constant App" do
      Object.constants.should include(:App)
    end

    it "should respond to getter" do
      App.should respond_to(:description)
    end

    it "should respond to setter" do
      App.should respond_to(:description=)
    end

    it "should define App as module" do
      App.class.should be(Module)
    end

    it "should retain value" do
      App.description = "HOWTO Ruby Metaprogramming"
      App.description.should == "HOWTO Ruby Metaprogramming"
      App.instance_variables.should include(:"@description")
    end
  end

  context "Exercise #3" do
    it "should define Person constant" do
      Object.constants.should include(:Person)
    end

    it "should be a Person subclass" do
      klass = new_class
      klass.superclass.should be(Person)
    end
  end

  context "Exercise #4" do
    it "should define Awesome constant" do
      Object.constants.should include(:Awesome)
    end

    it "should return name" do
      Awesome.name.should == "Awesome"
    end
  end

  context "Exercise #5" do
    let(:howto) { ::HOWTO.new }
    let(:metaprogramming) { ::RubyMetaprogramming.new }

    before do
      new_method(howto)
      new_method(metaprogramming)
    end

    it "should respond to hello" do
      howto.should respond_to(:hello)
      metaprogramming.should respond_to(:hello)
    end

    it "should return message" do
      howto.hello.should == "Hello from HOWTO instance"
      metaprogramming.hello.should == "Hello from RubyMetaprogramming instance"
    end
  end
end
