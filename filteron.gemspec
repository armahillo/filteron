
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "filteron/version"

Gem::Specification.new do |spec|
  spec.name          = "filteron"
  spec.version       = Filteron::VERSION
  spec.authors       = ["Aaron Hill"]
  spec.email         = ["armahillo@gmail.com"]

  spec.summary       = %q{Provides layered filtering for ActiveRecord models}
  spec.description   = %q{Filteron acts as a bridge connecting filter form controls to your ActiveRecord scope, allowing for multi-layered combined scoping.}
  spec.homepage      = "http://amhill.net"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # For the `filterable` concern. When in Rails this is implicit.
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", ">= 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
