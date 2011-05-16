require "rspec/core/rake_task"

RSpec::Core::RakeTask.new do |t|
  t.ruby_opts = "-Ifiles"
end

(1..5).each do |i|
  RSpec::Core::RakeTask.new("spec:day_#{i}") do |t|
    t.ruby_opts = "-Ifiles"
    t.pattern = "./spec/files/day_#{i}_spec.rb"
  end
end
