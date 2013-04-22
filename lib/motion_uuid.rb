require File.expand_path(File.join(File.dirname(__FILE__), "motion_uuid/version"))

unless defined?(Motion::Project::Config)
  raise "The motion_uuid gem must be required within a RubyMotion project Rakefile."
end

Motion::Require.all(Dir.glob(File.expand_path('../motion_uuid/**/*.rb', __FILE__)))
