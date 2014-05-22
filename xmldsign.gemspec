# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xmldsign/version'

Gem::Specification.new do |gem|
  gem.name          = "xmldsign"
  gem.version       = Xmldsign::VERSION
  gem.authors       = ["Anton Sozontov"]
  gem.email         = ["a.sozontov@gmail.com"]
  gem.description   = %q{Xmldsign library for ruby with GOST algorithms}
  gem.summary       = %q{Xmldsign library for ruby with GOST algorithms. Work in progress...}
  gem.homepage      = ""

  gem.extensions  = ["ext/xmldsign/extconf.rb"]

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'libxml-ruby'
  gem.add_dependency 'libxslt-ruby'
  gem.add_development_dependency 'rake-compiler', "~> 0.7.7"
  gem.add_development_dependency 'rake', '0.8.7' # NB: 0.8.7 required by rake-compiler 0.7.9
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
end
