# frozen_string_literal: true

require_relative 'attributes/form'

module Tailwind
  module Scaffold
    module Attributes
      extend ActiveSupport::Concern

      included do
        include Tailwind::Scaffold::Attributes::Form
        include Tailwind::Scaffold::Attributes::Show

        helper_method :resource_attributes,
          :index_attributes

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
      end

    end
  end
end
