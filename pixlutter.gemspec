# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pixlutter/version'

Gem::Specification.new do |spec|
  spec.name          = "pixlutter"
  spec.version       = Pixlutter::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.summary       = %q{The jolly file viewer for pixtures by Ruby/Clutter.}
  spec.homepage      = "https://github.com/myokoym/pixlutter-ruby"
  spec.license       = "LGPLv2.1 or later"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("clutter")

  spec.add_development_dependency("test-unit")
  spec.add_development_dependency("test-unit-notify")
  spec.add_development_dependency("test-unit-rr")
  spec.add_development_dependency("bundler", "~> 1.6")
  spec.add_development_dependency("rake")
end
