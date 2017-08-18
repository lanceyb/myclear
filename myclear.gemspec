# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "myclear/version"

Gem::Specification.new do |spec|
  spec.name          = "myclear"
  spec.version       = Myclear::VERSION
  spec.authors       = ["lance"]
  spec.email         = ["lance.zyb@gmail.com"]

  spec.summary       = %q{sdb for MyClear.}
  spec.description   = %q{sdb for MyClear.}
  spec.homepage      = "https://github.com/lanceyb/myclear"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "webmock", '~> 3.0.1'
end
