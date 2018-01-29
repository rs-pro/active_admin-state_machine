require 'active_admin'
require 'state_machines'

# optional dependency
begin
  require 'devise'
rescue
  puts 'Devise not loaded'
end

require 'active_admin/state_machine/dsl'
require 'active_admin/state_machine/view_dsl'
require 'active_admin/state_machine/engine'

ActiveAdmin::DSL.send :include, ActiveAdmin::StateMachine::DSL
ActiveAdmin::Views::IndexAsTable.send :include, ActiveAdmin::StateMachine::ViewDSL
