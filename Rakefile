require 'spec/rake/spectask'

task :default=>'spec:gameplay'

Spec::Rake::SpecTask.new('spec:gameplay') do |t|
  t.pattern   = 'spec/**/*_spec.rb'
  t.spec_opts = ['--color']
end


