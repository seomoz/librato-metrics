require 'bundler'

# Packaging
Bundler::GemHelper.install_tasks

# Testing
require 'rspec/core/rake_task'

desc "Run all tests"
task :spec do
  Rake::Task['spec:unit'].execute
  if ENV['TEST_API_USER'] && ENV['TEST_API_KEY']
    Rake::Task['spec:integration'].execute
  else
    puts "TEST_API_USER and TEST_API_KEY not in environment, skipping integration tests..."
  end
end

namespace :spec do
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.rspec_opts = '--color'
    t.pattern = 'spec/unit/**/*_spec.rb'
  end

  RSpec::Core::RakeTask.new(:integration) do |t|
    t.rspec_opts = '--color'
    t.pattern = 'spec/integration/**/*_spec.rb'
  end
end

task :default => :spec
task :test => :spec

# Docs
require 'yard'
YARD::Rake::YardocTask.new

# IRB
desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/librato/metrics.rb"
end

