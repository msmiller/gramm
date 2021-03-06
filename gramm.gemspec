$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gramm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gramm"
  s.version     = Gramm::VERSION
  s.authors     = ["Mark Miller"]
  s.email       = ["mmiller@sharp-stone.net"]
  s.homepage    = "http://www.sharp-stone.net"
  s.summary     = "A light, full-featured messaging system."
  s.description = "A user-to-user messaging system focused on being easy to integrate."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "awesome_print"
  # s.add_runtime_dependency 'activerecord', ['~> 5.0']
end
