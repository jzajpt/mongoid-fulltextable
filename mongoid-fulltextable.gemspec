# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid/fulltextable-version"

Gem::Specification.new do |s|
  s.name        = "mongoid-fulltextable"
  s.version     = Mongoid::Fulltextable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jiri Zajpt"]
  s.email       = ["jzajpt@blueberry.cz"]
  s.homepage    = "http://rubygems.org/gems/mongoid-fulltextable"
  s.summary     = %q{Simple & stupid 'fulltext' searching for Mongoid.}
  s.description = %q{Simple & stupid 'fulltext' searching for Mongoid.}

  s.rubyforge_project = "mongoid-fulltextable"
  
  s.add_dependency 'activesupport', '~> 3.0.1'
  s.add_dependency 'unicode_utils', '~> 1.0.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
