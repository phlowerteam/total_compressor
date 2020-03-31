# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'total_compressor/version'

Gem::Specification.new do |spec|
  spec.name          = 'total_compressor'
  spec.version       = TotalCompressor::VERSION
  spec.authors       = ['PhlowerTeam']
  spec.email         = ['phlowerteam@gmail.com']
  spec.description   = %q{Tool (wrapper) for compression and handling multiple type of archives (Zip, GZip, RAR, 7z)}
  spec.summary       = %q{Uses system calls}
  spec.homepage      = 'https://github.com/phlowerteam'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ['tcomp']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'rspec', '~> 0'

  spec.add_runtime_dependency 'awesome_print', '~> 1.1', '>= 1.1.0'
  spec.add_runtime_dependency 'rubyzip', '~> 1.2', '>= 1.2.2'
end
