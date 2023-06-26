# frozen_string_literal: true

module Tailwind
  module Scaffold
    module Attributes
      module Show
        extend ActiveSupport::Concern

        included do

          helper_method :resource_show_attributes, :show_title, :show_for_attributes, :show_for

          def resource_show_attributes
            resource_attributes
          end

          def show_title(resource)
            resource.respond_to?(:name) ? resource.name : "#{resource.class.name} (#{resource.id})"
          end

          def show_for_attributes
            resource_show_attributes.each_with_object({}) do |attribute, hash|
              hash[attribute] = show_for(attribute)
            end
          end

          def show_for(attribute)
            # if user defined method exists, use that
            custom_show_for_attribute = "show_for_#{attribute}".to_sym
            return send(custom_show_for_attribute) if respond_to?(custom_show_for_attribute)

            # if attribute is has_many association, use association index
            return resource_index_for(attribute) if resource_associations.include?(attribute)

            return { type: :enum } if resource.defined_enums[attribute.to_s].present?

            default_show_field_for attribute
          end

          def default_show_field_for(attribute)
            case resource.columns_hash[attribute.to_s].type
            when :string
              { type: :humanize }
            when :text
              { type: :raw }
            else
              { type: resource.columns_hash[attribute.to_s].type }
            end
          end

        end

      end
    end
  end
end
