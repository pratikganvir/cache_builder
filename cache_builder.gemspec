# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cache_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "cache_builder"
  spec.version       = CacheBuilder::VERSION
  spec.authors       = ["Pratik"]
  spec.email         = ["pganvir@digitsexperts.com"]
  spec.summary       = %q{Make look like everything is in cache.}
  spec.description   = %q{Make dynamic pages look like it was always in cache. I was stuck in speeding
up my Rails website. It was very slow even when there are very few queries.
I found out that cache can save me. I started using the cache and wow my website
became 400% faster. The only slowness was in the dynamic pages because first time when user sees it it was not in cache. So I have started writing this library to build the cache for the dynamic pages. Now when user visits my website first time
it is way too fast.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
