# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cwid"
  spec.version       = '0.1.0'
  spec.authors       = ['Ethan Turkeltaub']
  spec.email         = ['sga.itc@marist.edu']
  spec.summary       = %q{A simple Gem for Marist Campus-Wide Identification lookup.}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/marist-sga/cwid'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9.1'
  spec.add_dependency 'faraday_middleware', '~> 0.9.1'
  spec.add_dependency 'multi_xml', '~> 0.5.5'
  spec.add_dependency 'ox', '~> 2.1.8'
end
