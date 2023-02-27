# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "okay/version"

Gem::Specification.new do |spec|
  spec.name          = "okay"
  spec.version       = Okay::VERSION
  spec.authors       = ["Ellen Marie Dash"]
  spec.email         = ["me@duckie.co"]

  spec.summary       = %q{Okay, minimalist implementations of common utilities.}
  spec.description   = %q{Okay, minimalist implementations of common utilities in Ruby. E.g., HTTP fetchers.}
  spec.homepage      = "https://github.com/duckinator/okay"
  spec.license       = "MIT"

  spec.files         = ['README.md', 'LICENSE.txt', 'okay.gemspec'] + Dir['lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Okay only supports Ruby versions under "normal maintenance".
  # This number should be updated when a Ruby version goes into security
  # maintenance.
  #
  # Ruby maintenance info: https://www.ruby-lang.org/en/downloads/branches/
  #
  # NOTE: Update Gemfile when this is updated!
  spec.required_ruby_version = ">= 3.0"

  spec.add_runtime_dependency "cacert"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.8"
end
