Gem::Specification.new do |s|
  s.name        = "acts_as_publisher"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["PiotrChmolowski"]
  s.email       = ["carlhuda@engineyard.com"]
  s.homepage    = "http://github.com/carlhuda/acts_as_publisher"
  s.summary     = "A new gem templates"
  s.description = "You're definitely going to want to replace a lot of this"

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "acts_as_publisher"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  # If you need an executable, add it here
  # s.executables = ["acts_as_publisher"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end