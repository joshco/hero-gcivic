
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hero/gcivic/version"

Gem::Specification.new do |spec|
  spec.name          = "hero-gcivic"
  spec.version       = Hero::Gcivic::VERSION
  spec.authors       = ["Josh Cohen"]
  spec.email         = ["joshco@joshco.org"]

  spec.summary       = %q{Ruby Google civic api.}
  spec.homepage      = "https://github.com/joshco/hero-gcivic"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib","app"]

  spec.add_dependency "rails", "~> 4.2.0"
  spec.add_dependency "railties"
  spec.add_dependency "activemodel"
  spec.add_development_dependency 'bootstrap-sass'
  spec.add_development_dependency 'haml'
  spec.add_development_dependency 'haml-rails'
  spec.add_development_dependency 'jquery-rails'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "dotenv"
end
