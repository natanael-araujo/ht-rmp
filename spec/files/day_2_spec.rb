# -*- encoding: utf-8 -*-
require "spec_helper"

describe "Exercises: Day 2" do
  context "Exercise #1" do
    it "should send message" do
      Message.any_instance.expects(:send).with(:deliver)
      send_message
    end
  end

  context "Exercise #2" do
    it "should send message with arguments" do
      Message.expects(:__send__).with(:send, instance_of(Message), any_of(1, 2, 3))
      send_message_with_args
    end
  end

  context "Exercise #3" do
    it "should send private message" do
      Message.any_instance.expects(:send).with(:prepare)
      send_private_method
    end
  end

  context "Exercise #4" do
    it "should raise when executing private methods" do
      expect { send_public_method }.to raise_error(NoMethodError)
    end
  end

  context "Exercise #5" do
    it "should define constant Song" do
      Object.constants.should include(:Song)
    end

    it "should set attributes from hash" do
      song = Song.new(:title => "My God", :artist => "Pennywise", :duration => "2:48")

      song.title.should == "My God"
      song.artist.should == "Pennywise"
      song.duration.should == "2:48"
    end
  end

  context "Exercise #6" do
    specify "String should respond to to_leet" do
      "surrealismo".should respond_to(:to_leet)
    end

    it "should convert string to leet" do
      "surrealismo".to_leet.should == "sμrr34l1sm0"
    end
  end

  context "Exercise #7" do
    let(:klass) { Class.new { leet_attr :name, :blog } }
    let(:object) { klass.new }

    it "should implement Object.leet_attr method" do
      Object.should respond_to(:leet_attr)
    end

    it "should add getter" do
      object.should respond_to(:blog)
    end

    it "should add setter" do
      object.should respond_to(:blog=)
    end

    it "should add leet method" do
      object.should respond_to(:bl0g)
    end

    it "should return leet string" do
      object.blog = "ruby metaprogramming"
      object.bl0g.should == "rμby m3t4pr0gr4mm1ng"
    end
  end

  context "Exercise #8" do
    let(:klass) { Class.new { reverse_attr :name, :blog } }
    let(:object) { klass.new }

    it "should implement Object.reverse_attr method" do
      Object.should respond_to(:reverse_attr)
    end

    it "should add getter" do
      object.should respond_to(:blog)
    end

    it "should add setter" do
      object.should respond_to(:blog=)
    end

    it "should add leet method" do
      object.should respond_to(:golb)
    end

    it "should return reversed string" do
      object.blog = "ruby metaprogramming"
      object.golb.should == "ruby metaprogramming".reverse
    end
  end

  context "Exercise #9" do
    it "should not respond to Car.useless" do
      Car.should_not respond_to(:useless)
    end
  end

  context "Exercise #10" do
    subject { Ferrari.new }

    it "should respond to Ferrari#color" do
      subject.should respond_to(:color)
    end

    it "should return original value" do
      subject.color.should == "black"
    end
  end

  context "Exercise #11" do
    subject { Ferrari.new }

    it "should not respond to Ferrari#engine" do
      subject.should_not respond_to(:engine)
    end

    it "should raise NoMethodError" do
      expect { subject.engine }.to raise_error(NoMethodError)
    end
  end

  context "Exercise #12" do
    it "should sum two numbers" do
      Calc.sum(1,2).should == 3
    end

    it "should not raise when receive nil values" do
      expect { Calc.sum(nil,4).should == 4 }.to_not raise_error
    end
  end
end
