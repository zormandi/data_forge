# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_forge/version'

Gem::Specification.new do |spec|
  spec.name          = "data_forge"
  spec.version       = DataForge::VERSION
  spec.authors       = ["Zoltan Ormandi"]
  spec.email         = ["zoltan.ormandi@gmail.com"]
  spec.description   = %q{DataForge is a data manipulation tool for transferring (and transforming) data between flat files and databases.}
  spec.summary       = %q{Pure Ruby ETL and data manipulation tool.}
  spec.homepage      = "https://github.com/zormandi/data_forge"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber", "~> 1.3.15"
  spec.add_development_dependency "aruba", "~> 0.5.4"
end
