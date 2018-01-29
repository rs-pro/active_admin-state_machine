module ActiveAdmin
  module StateMachine
    module ViewDSL
      def state(name = "state", read_only: false)
        column name do |resource|
          render_state(resource, name, read_only)
        end
      end

      def render_state(resource, name, read_only)
        state = resource.send(name)
        s = resource.class.state_machines[name.to_sym].states[state.to_sym]
        ret = [
          '<div class="status_tag state-' + state + '">' + s.human_name + '</div>',
          '<div style="height: 10px;"></div>'
        ]
        unless read_only
          events = resource.class.state_machines[name.to_sym].events
          resource.send("#{name}_events".to_sym).each do |event|
            ret << link_to(
              events[event].human_name,
              send("#{event}_admin_#{resource.class.model_name.singular}_path", id: resource.id, attr: name),
              method: :put,
              class: "btn event-#{event}",
              #remote: true,
              style: 'margin-bottom: 5px;'
            )
          end
        end
        ('<div style="white-space: normal;">' + ret.join(' ') + '</div>').html_safe
      end
    end
  end
end

