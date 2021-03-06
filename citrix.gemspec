require "./lib/citrix/version"

Gem::Specification.new do |spec|
  spec.name          = "citrix"
  spec.version       = Citrix::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]
  spec.summary       = "API wrappers for Citrix services like GoToTraining."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/fnando/citrix"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "aitch", ">= 1.0.1"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry-meta"
end
