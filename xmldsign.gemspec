# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xmldsign/version'

Gem::Specification.new do |gem|
  gem.name          = "xmldsign"
  gem.version       = Xmldsign::VERSION
  gem.authors       = ["Anton Sozontov"]
  gem.email         = ["a.sozontov@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'nokogiri'
  gem.add_dependency 'libxml-ruby'
  gem.add_development_dependency 'rake-compiler', "~> 0.7.7"
  gem.add_development_dependency 'rake', '0.8.7' # NB: 0.8.7 required by rake-compiler 0.7.9
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'pry-debugger'
end
