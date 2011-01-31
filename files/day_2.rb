# -*- encoding: utf-8 -*-

# Solução do exercício 1
#
# Para executar um método dinamicamente, basta utilizar o método send,
# que recebe como parâmetro o nome do método.
#
def send_message
  message = Message.new
  message.send :deliver
end

# Solução do exercício 2
#
# O método send pode ser sobrescrito. Neste caso, você
# deve utilizar o método reservado __send__.
# Além do nome do método, o método send também permite que
# você passe argumentos para o método que será executado.
#
def send_message_with_args
  Message.__send__ :send, Message.new, 1
end

# Solução do exercício 3
#
# Métodos privados podem ser executados. Para isso, utilize o
# método send.
#
def send_private_method
  Message.new.send :prepare
end

# Solução do exercício 4
#
# Nem sempre queremos enviar uma mensagem para um método privado.
# Neste caso, você pode garantir que somente executará métodos
# públicos utilizando o método public_send.
#
def send_public_method
  Message.new.public_send :prepare
end

# Solução do exercício 5
#
# Você também pode executar métodos, compondo seu
# nome dinamicamente.
#
# Neste exemplo não precisamos especificar o receiver
# do writer porque estamos explicitamente executando
# um método `title=`, por exemplo.
#
class Song
  attr_accessor :title, :artist, :duration

  def initialize(attributes = {})
    attributes.each {|name, value| send("#{name}=", value)}
  end
end

# Solução do exercício 6
#
# É possível definir novos métodos em objetos existentes
# utilizando as classes abertas do Ruby.
#
# Este tipo de técnica é a base do ActiveSupport.
#
class String
  LEET = {
    "a" => "4",
    "e" => "3",
    "i" => "1",
    "o" => "0",
    "u" => "μ"
  }

  def to_leet
    self.dup.tap do |str|
      LEET.each {|from, to| str.gsub!(from, to)}
    end
  end
end

# Solução do exercício 7
#
# Como adicionamos um método de classe na classe Object,
# podemos executar o método attr_accessor diretamente.
#
# Depois, basta definir o método utilizando o método define_method.
# Nesse método nós executamos o método dinamicamente, transformando
# o retorno em uma versão Leet.
#
class Object
  def self.leet_attr(*names)
    names.each do |name|
      attr_accessor name

      leet_method = name.to_s.to_leet
      leet_method = "_" + leet_method if leet_method =~ /^[\dμ]/

      define_method(leet_method) do
        send(name).to_s.to_leet
      end
    end
  end
end

# Solução do exercício 8
#
# Assim como no exemplo anterior, podemos executar o método
# attr_accessor diretamente, pois estamos no mesmo contexto.
#
# A diferença é que estamos usando o class_eval para executar
# uma string com código Ruby no nível da classe.
#
class Object
  def self.reverse_attr(*names)
    names.each do |name|
      attr_accessor name

      reverse_method = name.to_s.reverse
      reverse_method = "_" + reverse_method if reverse_method =~ /^\d/

      class_eval <<-RUBY
        def #{reverse_method}
          #{name}.to_s.reverse
        end
      RUBY
    end
  end
end


# Solução do exercício 9
#
# Para remover um método de classe, você precisará executar
# o método remove_method no contexto da classe Singleton.
#
class << Car
  remove_method :useless
end

# Solução do exercício 10
#
# Para remover um método de instância, você precisará
# executar o método remove_method no contexto da classe.
#
# Você precisará utilizar o método send, pois o método remove_method
# é privado.
#
# O método remove_method não remove o acesso aos métodos
# disponíveis em superclasses.
#
Ferrari.send :remove_method, :color

# Solução do exercício 11
#
# Assim como o exercício anterior, podemos utilizar o método undef_method.
# A diferença é que o método undef_method remove o acesso inclusive de
# métodos definidos em superclasses.
#
Ferrari.send :undef_method, :engine

# Solução do exercício 12
#
# Para sobrescrever o comportamento de um método existente,
# atribuímos uma cópia do método Calc#sum à variável local sum.
#
# Depois utilizamos esta variável dentro do método define_method,
# passando os argumentos convertidos para inteiro.
#
module Calc
  sum = instance_method(:sum)
  define_method(:sum) do |n1, n2|
    sum.bind(self).call(n1.to_i, n2.to_i)
  end
end
