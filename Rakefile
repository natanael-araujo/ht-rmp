require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << File.dirname(__FILE__)
  t.test_files = FileList["test/**/test*.rb"]
  t.warning = true
end