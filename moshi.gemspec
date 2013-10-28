# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moshi/version'

Gem::Specification.new do |spec|
  spec.name          = "moshi"
  spec.version       = Moshi::VERSION
  spec.authors       = ["Kyle J Aleshire\n"]
  spec.email         = ["kjaleshire@gmail.com"]
  spec.summary       = "A mispelled word correcter and generator"
  spec.description   = "A mispelled word correcter and generator"
  spec.homepage      = "http://github.com/kjaleshire"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
