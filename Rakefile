# encoding: utf-8
require 'rubygems'
require 'rspec/core/rake_task'

task :default => :dots
desc 'verbose output'
RSpec::Core::RakeTask.new(:verbose) do |t|
  t.pattern = "spec/grammar_cards/**/*_spec.rb"
  t.rspec_opts = ["--color" , "--format" , "doc" ]
end

desc 'dot output'
RSpec::Core::RakeTask.new(:dots) do |t|
  t.pattern = "spec/grammar_cards/**/*_spec.rb"
end
