# encoding: utf-8
require 'rubygems'
require 'rspec/core/rake_task'

task :default => :spec
desc 'test'
RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/grammar_cards/**/*_spec.rb"
  t.rspec_opts = ["--color" , "--format" , "doc" ]
end
