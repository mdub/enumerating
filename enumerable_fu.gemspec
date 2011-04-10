# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "enumerable_fu/version"

Gem::Specification.new do |s|

  s.name          = "enumerable_fu"
  s.version       = EnumerableFu::VERSION.dup
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Mike Williams"]
  s.email         = "mdub@dogbiscuit.org"
  s.homepage      = "http://github.com/mdub/enumerable_fu"

  s.summary       = %{Lazy extensions to Enumerable}
  s.description   = %{EnumerableFu extends Enumerable with "lazy" versions of various operations, allowing streamed processing of large (or even infinite) collections.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

end
