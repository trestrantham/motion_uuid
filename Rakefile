$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler/gem_tasks'
require 'bundler/setup'
require 'motion-require'
require 'rm-digest'

Motion::Require.all

$:.unshift("./lib/")
require './lib/motion_uuid'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'motion_uuid'
end
