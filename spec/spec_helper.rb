require "mocha"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|file| require File.expand_path(file)}
Dir[File.dirname(__FILE__) + "/../files/**/*.rb"].each {|file| require File.expand_path(file)}

RSpec.configure do |config|
  config.mock_with :mocha
end