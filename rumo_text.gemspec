# -*- encoding: utf-8 -*-
#VERSION = "1.0"
require File.expand_path('../lib/project/rumo_text/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "rumo_text"
  spec.version       = RumoText::VERSION
  spec.authors       = ["Hiroki Ata"]
  spec.email         = ["hiroki.ata@gmail.com"]
  spec.description   = 'Wrapper classes to use iOS Core Text'
  spec.summary       = 'Wrapper classes to use iOS Core Text'
  spec.homepage      = ""
  spec.license       = ""

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
