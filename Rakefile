require 'spec/rake/spectask'

task :default=>:spec
task :spec=>['spec:engine']

Spec::Rake::SpecTask.new('spec:engine') do |t|
  t.pattern   = 'spec/engine/*_spec.rb'
  t.spec_opts = ['--color']
end

