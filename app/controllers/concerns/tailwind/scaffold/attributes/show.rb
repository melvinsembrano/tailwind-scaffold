# frozen_string_literal: true

module Tailwind
  module Scaffold
    module Attributes
      module Show
        extend ActiveSupport::Concern

        included do

          helper_method :resource_show_attributes, :show_title, :show_for

          def resource_show_attributes
            resource_attributes
          end

          def show_title(resource)
            resource.respond_to?(:name) ? resource.name : "##{resource.class.name} ##{resource.id}"
          end

          def show_for(attribute)
            # if user defined method exists, use that
            custom_show_for_attribute = "show_for_#{attribute}".to_sym
            return send(custom_show_for_attribute) if respond_to?(custom_show_for_attribute)

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
