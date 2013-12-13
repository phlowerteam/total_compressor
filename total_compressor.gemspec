# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'total_compressor/version'

Gem::Specification.new do |spec|
  spec.name          = "total_compressor"
  spec.version       = TotalCompressor::VERSION
  spec.authors       = ["PhlowerTeam"]
  spec.email         = ["phlowerteam@gmail.com"]
  spec.description   = %q{Wrapper for handling multiple type of archives}
  spec.summary       = %q{Supports zip, gzip, rar, 7z archive types}
  spec.homepage      = "https://github.com/phlowerteam"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["tcomp"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "awesome_print"
  spec.add_runtime_dependency "rubyzip", "~> 0.9.9"
end
