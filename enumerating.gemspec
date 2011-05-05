# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "enumerating/version"

Gem::Specification.new do |s|

  s.name          = "enumerating"
  s.version       = Enumerating::VERSION.dup
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Mike Williams"]
  s.email         = "mdub@dogbiscuit.org"
  s.homepage      = "http://github.com/mdub/enumerating"

  s.summary       = %{Lazy filtering/transforming of Enumerable collections}
  s.description   = %{Enumerating extends Enumerable with "lazy" versions of various operations, allowing streamed processing of large (or even infinite) collections.  Even in Ruby 1.8.x.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

end
