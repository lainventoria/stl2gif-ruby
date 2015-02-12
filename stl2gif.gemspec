# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stl2gif/version'

Gem::Specification.new do |spec|
  spec.name          = 'stl2gif'
  spec.version       = Stl2gif::VERSION
  spec.authors       = ['La Inventoria']
  spec.email         = ['stl2gif@lainventoria.com.ar']
  spec.summary       = %q{Convert STL files to GIF animations.}
  spec.description   = %q{Convert STL files to GIF animations using povray to generate each frame.}
  spec.homepage      = 'https://github.com/lainventoria/stl2gif-ruby'
  spec.license       = 'GPLv3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mustache'
  spec.add_dependency 'rmagick'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
end
