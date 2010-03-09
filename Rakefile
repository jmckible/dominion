require 'spec/rake/spectask'

task :default=>:spec
task :spec=>['spec:dominion'] # task :spec=>['spec:dominion', 'spec:terminal']

Spec::Rake::SpecTask.new('spec:dominion') do |t|
  t.pattern   = ['spec/dominion/**/*_spec.rb']
  t.spec_opts = ['--color']
end

Spec::Rake::SpecTask.new('spec:terminal') do |t|
  t.pattern   = ['spec/terminal/**/*_spec.rb']
  t.spec_opts = ['--color']
end

task :server do
  sh "ruby -Ilib -rdominion lib/server.rb"
end

task :console do
  desc "Start an irb session with required path and libraries. Use 'include Dominion'"
  sh "irb -Ilib -rdominion"
end

desc "Run scripts/simulation"
task :simulate do
  sh "ruby -Ilib -rdominion ./scripts/simulation.rb"
end