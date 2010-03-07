require 'spec/rake/spectask'

task :default=>:spec
task :spec=>['spec:units']

Spec::Rake::SpecTask.new('spec:units') do |t|
  t.pattern   = ['spec/units/**/*_spec.rb']
  t.spec_opts = ['--color']
end

task :console do
  sh "irb -Ilib -rdominion"
end

desc "Run scripts/simulation"
task :simulate do
  sh "ruby -Ilib -rdominion ./scripts/simulation.rb"
end

namespace :terminal do
  desc "Start a server. Defaults to port 8000"
  task :server do
    port = ENV['PORT'] || 8000
    sh "ruby -Ilib -rdominion -rterminal -e 'TerminalServer.new(#{port}).setup.run'"
  end

  desc "Play the game. Pass HOST or PORT as options"
  task :play do
    host = ENV['HOST'] || 'localhost'
    port = ENV['PORT'] || 8000
    sh "telnet #{host} #{port}"
  end
  
  desc "Start a server with an AI Big Money player sitting"
  task :big_money do
    port = ENV['PORT'] || 8000
    sh "ruby -Ilib -rdominion -rterminal_server -e 'TerminalServer.new(#{port}).setup.big_money.run'"
  end
  
  desc "Start a server with an AI Highlander player sitting"
  task :highlander do
    port = ENV['PORT'] || 8000
    sh "ruby -Ilib -rdominion -rterminal_server -e 'TerminalServer.new(#{port}).setup.highlander.run'"
  end
end
