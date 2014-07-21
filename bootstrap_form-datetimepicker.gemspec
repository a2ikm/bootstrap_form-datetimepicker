# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bootstrap_form/datetimepicker/version'

Gem::Specification.new do |spec|
  spec.name          = "bootstrap_form-datetimepicker"
  spec.version       = BootstrapForm::Datetimepicker::VERSION
  spec.authors       = ["Masato Ikeda"]
  spec.email         = ["masato.ikeda@gmail.com"]
  spec.summary       = %q{bootstrap_form add-on to embed bootstrap-datetimepicker simply.}
  spec.description   = %q{bootstrap_form add-on to embed bootstrap-datetimepicker simply.}
  spec.homepage      = "https://github.com/a2ikm/bootstrap_form-datetimepicker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "bootstrap_form"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
