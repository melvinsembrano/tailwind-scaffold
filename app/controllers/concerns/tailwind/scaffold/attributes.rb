# frozen_string_literal: true

module Tailwind
  module Scaffold
    module Attributes
      extend ActiveSupport::Concern

      # rubocop:disable Metrics/BlockLength
      included do

        helper_method :resource_attributes,
          :index_attributes, :form_fields

        def resource_attributes
          resource.attribute_names.map(&:to_sym)
        end

        def resource_index_attributes
          resource_attributes
        end

        def index_attributes
          resource_index_attributes.each_with_object({}) do |attribute, hash|
            hash[attribute] = { type: resource.columns_hash[attribute.to_s]&.type || :string }
          end
        end

        def resource_create_attributes
          resource_attributes.excluding(:id, :created_at, :updated_at)
        end

        def resource_update_attributes
          resource_attributes.excluding(:id, :created_at, :updated_at)
        end

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

        # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
        def form_field_for(attribute)
          custom_field_for_attribute = "form_field_for_#{attribute}".to_sym
          return send(custom_field_for_attribute) if respond_to?(custom_field_for_attribute)

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
        # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity
      end
      # rubocop:enable Metrics/BlockLength
    end
  end
end
