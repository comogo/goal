$:.push File.expand_path("../lib", __FILE__)
require "goal"

Gem::Specification.new do |s|
  s.name        = "goal"
  s.version     = Goal::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ["MIT"]
  s.summary     = "Keep track of your hour goals"
  s.email       = "mcomogo@gmail.com"
  s.homepage    = "http://github.com/comogo/goal"
  s.description = s.summary
  s.authors     = ['Mateus Lorandi dos Santos']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
  s.executables << 'goal'

  s.add_dependency 'ruby-freshbooks', '~> 0.4.1'

  s.add_development_dependency 'colorize', '~> 0.6.0'
end
