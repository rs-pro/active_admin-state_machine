$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/state_machine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rs-active_admin-state_machine"
  s.version     = ActiveAdmin::StateMachine::VERSION
  s.authors     = ["glebtv", "Matt Brewer"]
  s.email       = ["glebtv@gmail.com"]
  s.homepage    = "https://github.com/rs-pro/active_admin-state_machine"
  s.summary     = "Provides easy DSL integration between ActiveAdmin & state_machine"
  s.description = "Provides easy DSL integration between ActiveAdmin & state_machine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.2"
  s.add_dependency "activeadmin", ">= 1.0.0"
  s.add_dependency "state_machines"

  s.add_development_dependency "rake"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "devise"
  s.add_development_dependency "cancancan"
  s.add_development_dependency "puma"
  s.add_development_dependency "state_machines-activerecord"
end
