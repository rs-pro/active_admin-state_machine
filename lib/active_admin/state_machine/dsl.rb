module ActiveAdmin
  module StateMachine
    module DSL

      #
      # Easily tie into a state_machine action
      #
      # @param [Symbol] state machine event, ie: :publish
      # @param [Hash] options
      #   - permission [Symbol] permission to check authorization against
      #   - http_verb [Symbol] :put, :post, :get, etc
      #
      # Will call "resource.publish!", if "resource.can_publish?" returns true
      #


      def state_action(action, options={}, &controller_action)
        singular = config.resource_name.singular
        plural = config.resource_name.plural

        options[:permission] ||= controller.new.send(:action_to_permission, action)
        confirmation = options.fetch(:confirm, false)
        if confirmation == true
          default = "Are you sure you want to #{action.to_s.humanize.downcase}?"
          confirmation = ->{ I18n.t(:confirm, scope: "#{plural}.#{action}", default: default) }
        end

        http_verb = options.fetch :http_verb, :put

        action_item_args = if ActiveAdmin::VERSION.start_with?('0.')
                             [{ only: :show }]
                           else
                             ["state_action_#{action}", { only: :show }]
                           end
        action_item(*action_item_args) do
          if resource.send("can_#{action}?") && authorized?(options[:permission], resource)
            path = resource_path << "/#{action}"
            label = I18n.t("#{plural}.#{action}.label", default: action.to_s.titleize)

            link_options = {}
            if confirmation.is_a?(Proc)
              link_options[:data] ||= {}
              link_options[:data][:confirm] = instance_exec(&confirmation)
            end

            link_options[:class] = "btn btn-large"
            link_options[:method] = http_verb

            link_to label, path, link_options
          end
        end

        unless block_given?
          controller_action = -> do
            events = resource.class.state_machines[params[:attr].to_sym].events
            if resource.send(action)
              flash[:notice] = t("#{plural}.#{action}.flash.success", default: t("active_admin-state_machine.flash.success", action: events[action].human_name, resource: resource.model_name.human))
            else
              flash[:error] = resource.errors.full_messages.join(", ")
            end
            redirect_back(fallback_location: smart_resource_url)
          end
        end

        member_action action, method: http_verb, &controller_action
      end

    end
  end
end
