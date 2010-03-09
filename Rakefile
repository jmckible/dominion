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

namespace :terminal do
  desc "Start a server. Defaults to port 8000"
  task :server do
    port = ENV['PORT'] || 8000
    sh "ruby -Ilib -rdominion -rterminal -e 'Terminal::Server.new(#{port}).setup.run'"
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
    sh "ruby -Ilib -rdominion -rterminal -e 'Terminal::Server.new(#{port}).setup.big_money.run'"
  end
  
  desc "Start a server with an AI Highlander player sitting"
  task :highlander do
    port = ENV['PORT'] || 8000
    sh "ruby -Ilib -rdominion -rterminal -e 'Terminal::Server.new(#{port}).setup.highlander.run'"
  end
end
