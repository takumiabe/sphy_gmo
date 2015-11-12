# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sphy_gmo/version'

Gem::Specification.new do |spec|
  spec.name          = "sphy_gmo"
  spec.version       = SphyGmo::VERSION
  spec.authors       = ["Takumi Abe"]
  spec.email         = ["abe@engraphia.com"]
  spec.license       = 'MIT'

  spec.summary       = %q{gmo wrapper}
  spec.description   = %q{easy-testable gmo wrapper}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_dependency "gmo", "~> 0.2"
  spec.add_dependency "webmock", "~> 1.21"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "awesome_print", "~> 1.6"
  spec.add_development_dependency "pry", "~> 0.10"
end
