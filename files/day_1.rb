# Solução do exercício 1
#
# Para retornar a classe Singleton de um objeto,
# basta acessar utilizando a notação `class << self; end`,
# retornando o próprio self.
#
class Object
  def metaclass
    class << self; self; end
  end
end

# Solução do exercício 2
#
# Para definir um accessor em uma classe ou módulo,
# você deve utilizar a classe Singleton, chamando
# o método attr_accessor.
#
module App
  class << self
    attr_accessor :description
  end
end

# Solução do exercício 3
#
# Para retornar uma nova classe criada dinamicamente,
# basta criar uma nova instância da classe Class.
#
# O método construtor da classe Class aceita um argumento,
# que será utilizada como a superclasse da nova classe.
#
class Person; end

def new_class
  Class.new(Person)
end

# Solução do exercício 4
#
# Classes e módulos são apenas objetos no Ruby.
# O seu nome é inferido da constante a que esta classe/módulo
# é atribuído.
#
Awesome = Class.new

# Solução do exercício 5
#
# Você pode definir novos métodos em um objeto.
# Estes métodos são adicionados como métodos Singleton.
#
def new_method(object)
  def object.hello
    "Hello from #{self.class.name} instance"
  end
end