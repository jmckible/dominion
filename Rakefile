require 'spec/rake/spectask'

task :default=>:spec
task :spec=>['spec:engine']

Spec::Rake::SpecTask.new('spec:engine') do |t|
  t.pattern   = 'spec/engine/**/*_spec.rb'
  t.spec_opts = ['--color']
end

task :console do
  sh "irb -Ilib -rdominion"
end

task :play do
  sh "ruby -Ilib -rdominion -e 'Game.new.play'"
end

