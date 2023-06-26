# frozen_string_literal: true

module Tailwind
  module Scaffold
    class Breadcrumb

      def initialize(controller)
        @controller = controller
        @resource = controller.instance_variable_get('@resource')
        @parent = controller.instance_variable_get('@parent')
      end

      def crumbs
        crumbs = []
        crumbs << parent_crumb if @parent
        crumbs << resource_index_crumb
        crumbs << resource_crumb if @resource
        crumbs.flatten
      end

      def resource_index_crumb
        {
          name: @controller.title,
          url: @controller.resource_list_url(parent_route_param)
        }
      end

      def resource_crumb
        {
          name: @controller.show_title(@resource),
          url: @controller.resource_url(@resource, parent_route_param)
        }
      end

      def parent_crumb
        parent_controller = @controller.resource_controller(@controller.class, @parent.class).new
        parent_controller.request = @controller.request
        parent_controller.instance_variable_set('@resource', @parent)

        Breadcrumb.new(parent_controller).crumbs
      end

      def parent_route_param
        if @parent
          {
            "#{@parent.class.model_name.param_key.to_sym}_id" => @parent.id
          }
        else
          {}
        end
      end

    end
  end
end
