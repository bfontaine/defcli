require "./lib/defcli"

Gem::Specification.new do |s|
  s.name          = "defcli"
  s.version       = Defcli.version
  s.date          = Time.now

  s.summary       = "Dictionnary CLI tools utilities"
  s.description   = "Utilities to build simple dictionnary CLI tools."
  s.license       = "MIT"

  s.author        = "Baptiste Fontaine"
  s.email         = "b@ptistefontaine.fr"
  s.homepage      = "https://github.com/bfontaine/defcli"

  s.files         = Dir.glob("lib/**/*.rb")
  s.test_files    = Dir.glob("tests/*tests.rb")
  s.require_path  = "lib"

  s.add_runtime_dependency "optimist", "~> 3.0"
  s.add_runtime_dependency "colored", "~> 1.2"

  s.add_development_dependency "simplecov", "~> 0.18"
  s.add_development_dependency "rake",      "~> 12.3"
  s.add_development_dependency "test-unit", "~> 3.3"
  s.add_development_dependency "coveralls", "~> 0.8"
end
