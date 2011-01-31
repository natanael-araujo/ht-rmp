#1
def Object.metaclass
  singleton_class
end

#2
module App
  extend self
  attr_accessor :description

end

#3
class Person
end

def new_class
  Class.new(Person)
end

#4
Awesome = Class.new

#5
def new_method(object)
  def object.hello
    "Hello from #{self.class.name} instance"
  end
end