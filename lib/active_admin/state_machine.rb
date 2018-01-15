require 'active_admin'
require 'state_machines'

require 'active_admin/state_machine/dsl'

ActiveAdmin::DSL.send :include, ActiveAdmin::StateMachine::DSL
