# frozen_string_literal: true

require_relative 'attributes/form'

module Tailwind
  module Scaffold
    module Attributes
      extend ActiveSupport::Concern

      # rubocop:disable Metrics/BlockLength
      included do
        include Tailwind::Scaffold::Attributes::Form
        include Tailwind::Scaffold::Attributes::Show

        helper_method :resource_attributes,
          :index_attributes, :resource_route_param

        def resource_attributes
          resource.attribute_names.map(&:to_sym)
        end

        def resource_index_attributes
          resource_attributes
        end

        def index_attributes
          resource_index_attributes.each_with_object({}) do |attribute, hash|
            hash[attribute] = {
              type: resource.columns_hash[attribute.to_s]&.type || :string,
              sortable: resource.columns_hash[attribute.to_s].present?,
              sort: attribute
            }
          end
        end

        def resource_create_attributes
          resource_attributes.excluding(:id, :created_at, :updated_at)
        end

        def resource_update_attributes
          resource_attributes.excluding(:id, :created_at, :updated_at)
        end

        def resource_associations
          @resource_associations ||= resource.reflect_on_all_associations.map(&:name)
        end

        def resource_controller(base_controller, resource)
          namespace = base_controller.name.split('::')
          namespace.pop
          namespace.push "#{resource.model_name.element.pluralize.camelize}Controller"
          namespace.join('::').constantize
        end

        def resource_index_for(attribute)
          controller = resource_controller(self.class, resource.reflect_on_association(attribute).klass)

          { type: :has_many, association: attribute, controller: }
        end

        def resource_route_param(object)
          { "#{resource_name.underscore}_id": object.id }
        end

      end
      # rubocop:enable Metrics/BlockLength

    end
  end
end
