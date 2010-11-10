require "bundler"
Bundler.setup

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts  = %w(-fs --color)
  t.warning    = true
end

gemspec = eval(File.read("acts_as_publisher.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["acts_as_publisher.gemspec"] do
  system "gem build acts_as_publisher.gemspec"
  system "gem install acts_as_publisher-#{ActsAsPublisher::VERSION}.gem"
end