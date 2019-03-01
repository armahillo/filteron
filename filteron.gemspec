
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "filteron/version"

Gem::Specification.new do |spec|
  spec.name          = "filteron"
  spec.version       = Filteron::VERSION
  spec.authors       = ["Aaron Hill"]
  spec.email         = ["armahillo@gmail.com"]

  spec.summary       = %q{Searching / filtering for ActiveRecord models}
  spec.description   = %q{Filteron acts as a bridge connecting filter form controls to your ActiveRecord scope, allowing for multi-layered combined scoping.}
  spec.homepage      = "https://github.com/armahillo/filteron"
  spec.license       = "MIT"

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
  spec.add_development_dependency "rails", "~> 5.2"
  #spec.add_development_dependency "activerecord", ">= 5" # For tests
  spec.add_development_dependency "sqlite3", '~> 1.3', '< 1.4'
end
