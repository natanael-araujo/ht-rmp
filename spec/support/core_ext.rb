class Object
  def singleton_class
    class << self; self; end;
  end unless respond_to?(:singleton_class)

  class << self
    constants = instance_method(:constants)
    define_method :constants do
      constants.bind(self).call.collect {|name| name.to_sym}
    end
  end
end

class Module
  instance_variables = instance_method(:instance_variables)
  define_method :instance_variables do
    instance_variables.bind(self).call.collect {|name| name.to_sym}
  end

  instance_methods = instance_method(:instance_methods)
  define_method :instance_methods do
    instance_methods.bind(self).call.collect {|name| name.to_sym}
  end
end
