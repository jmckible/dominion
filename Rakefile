require 'spec/rake/spectask'

task :default=>:spec
task :spec=>['spec:engine']

Spec::Rake::SpecTask.new('spec:engine') do |t|
  t.pattern   = ['spec/ai/**/*_spec.rb', 'spec/engine/**/*_spec.rb']
  t.spec_opts = ['--color']
end

task :console do
  sh "irb -Ilib -rdominion"
end

task :server do
  sh "ruby -Ilib -rdominion -e 'Server.new.setup.run'"
end

task :play do
  puts "Server Address:"
  ip = STDIN.gets.chomp
  puts "Server Port:"
  port = STDIN.gets.chomp
  sh "telnet #{ip} #{port}"
end

