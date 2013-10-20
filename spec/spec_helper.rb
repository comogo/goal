$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "goal"
require "rspec"
require "rspec/autorun"

require "rubygems"

Dir["spec/support/**/*.rb"].each { |f| require f }
