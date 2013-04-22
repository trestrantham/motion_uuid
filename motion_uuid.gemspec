# -*- encoding: utf-8 -*-
require File.expand_path('../lib/motion_uuid/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "motion_uuid"
  s.version     = MotionUUID::VERSION
  s.authors     = ["Tres Trantham"]
  s.email       = ["tres@trestrantham.com"]
  s.homepage    = "https://github.com/trestrantham/motion_uuid"
  s.summary     = "UUIDTools for Rubymotion"
  s.description = "A lights UUIDTools wrapper for Rubymotion"

  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "motion_support"
  s.add_dependency "uuidtools"
  s.add_development_dependency 'rake'
end
