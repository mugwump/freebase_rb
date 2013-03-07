# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freebase_rb/version'

Gem::Specification.new do |gem|
  gem.name          = "freebase_rb"
  gem.version       = FreebaseRb::VERSION
  gem.authors       = ["Stefan Frank"]
  gem.email         = ["s.frank@vierundsechzig.de"]
  gem.description   = %q{Accessing the freebase json-api}
  gem.summary       = %q{Querying and refining results from freebase}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "httparty", "~> 0.10.2"
  gem.add_dependency "activesupport", "~> 3.2.12"
  gem.add_development_dependency "rspec", "~> 2.13"
end
