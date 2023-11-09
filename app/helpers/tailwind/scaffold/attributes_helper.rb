# frozen_string_literal: true

module Tailwind
  module Scaffold
    module AttributesHelper

      def format_header_title(value, options = {})
        if options[:sortable]
          link_to value.to_s.humanize, "#sort=#{options[:sort]}", class: 'underline'
        else
          value.to_s.humanize
        end
      end

      def format_cell_value(value, options = {})
        return options[:default] || '-' if value.blank?

        custom_cell_value_for_attribute = "format_cell_for_#{options[:attribute]}"
        if respond_to?(custom_cell_value_for_attribute)
          return send(custom_cell_value_for_attribute.to_sym, value, options)
        end

        format_cell_value_for_type(value, options[:type])
      end

      def format_cell_value_for_type(value, type)
        case type
        when :boolean
          value ? 'Yes' : 'No'
        when :datetime, :date, :time
          I18n.l(value, format: :short)
        when :text, :string
          truncate(value, length: 50)
        when :link
          link_to value, value, target: '_blank', class: 'text-blue-500 hover:underline'
        else
          value
        end
      end
    end
  end
end
