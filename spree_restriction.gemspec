# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_restriction'
  s.version     = '1.2.4'
  s.summary     = 'Spree extension for adding visibility restriction by roles to products.'
  s.description = 'Spree extension for adding visibility restriction by roles to products.'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Yanick Landry (Nurun)'
  s.email     = 'yanick.landry@nurun.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.2'

end
