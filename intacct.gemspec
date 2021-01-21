$LOAD_PATH.push File.expand_path("lib", __dir__)
# require 'intacct/version'

Gem::Specification.new do |spec|
  spec.name          = "intacct"
  spec.version       = "0.0.3"
  spec.authors       = ["Mavenlink, Inc.", "Adam Bedford", "CJ Lazell"]
  spec.email         = "opensource@mavenlink.com"
  spec.description   = "Ruby wrapper for the Intacct Web Services API"
  spec.summary       = "Ruby Intacct API Client"
  spec.homepage      = "http://github.com/mavenlink-solutions/intacct-ruby"

  spec.files = Dir["lib/**/*", "LICENSE.txt", "README.md"]
  spec.test_files    = Dir["spec/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "hooks"
  spec.add_dependency "nokogiri", "~> 1.10.10"

  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "dotenv-rails"
  spec.add_development_dependency "faker", ">=1.2.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "turnip"
end
