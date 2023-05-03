# frozen_string_literal: true

module Tailwind
  module Scaffold
    module Attributes
      module Form
        extend ActiveSupport::Concern

        # rubocop:disable Metrics/BlockLength
        included do

          helper_method :form_fields

          def resource_form_attributes(instance)
            if instance.persisted?
              resource_update_attributes
            else
              resource_create_attributes
            end
          end

          def resource_form_attributes_with_type(instance)
            resource_form_attributes(instance).map do |attribute|
              [attribute, resource.columns_hash[attribute.to_s]&.type || :string]
            end
          end

          def form_fields(instance)
            resource_form_attributes(instance).each_with_object({}) do |attribute, hash|
              hash[attribute] = form_field_for(attribute)
            end
          end

          private

          # rubocop:disable Metrics/AbcSize
          def form_field_for(attribute)
            # if user defined method exists, use that
            custom_field_for_attribute = "form_field_for_#{attribute}".to_sym
            return send(custom_field_for_attribute) if respond_to?(custom_field_for_attribute)

            # if attribute is a belongs_to association, use select
            if attribute.to_s.ends_with?('_id') &&
               resource.reflect_on_association(attribute.to_s.split('_id').first)&.belongs_to?
              return belongs_to_select_form_field_for(attribute)
            end

            # if attribute is an enum, use select
            return enum_select_form_field_for(attribute) if resource.defined_enums[attribute.to_s].present?

            default_form_field_for(attribute)
          end
          # rubocop:enable Metrics/AbcSize

          def belongs_to_select_form_field_for(attribute)
            collection = resource.reflect_on_association(attribute.to_s.split('_id').first).klass.all
            collection = collection.map { |item| [item.name, item.id] }

            { type: :select, collection:, options: { include_blank: true } }
          end

          def enum_select_form_field_for(attribute)
            collection = resource.defined_enums[attribute.to_s].keys.map { |key| [key.humanize, key] }

            { type: :select, collection:, options: { include_blank: true } }
          end

          def default_form_field_for(attribute)
            case resource.columns_hash[attribute.to_s].type
            when :string
              { type: :text_field }
            when :text
              { type: :text_area }
            when :integer
              { type: :number_field }
            when :datetime
              { type: :datetime_field }
            when :date
              { type: :date_field }
            when :boolean
              { type: :check_box }
            else
              { type: :text_field }
            end
          end

        end
        # rubocop:enable Metrics/BlockLength

      end
    end
  end
end
