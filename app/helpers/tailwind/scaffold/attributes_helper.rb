# frozen_string_literal: true

module Tailwind
  module Scaffold
    module AttributesHelper

      def format_header_title(value, options = {})
        value.to_s.humanize
      end

      def format_cell_value(value, options = {})
        return options[:default] || '-' if value.blank?

        format_cell_value_for_type(value, options[:type])
      end

      def format_cell_value_for_type(value, type)
        case type
        when :boolean
          value ? 'Yes' : 'No'
        when :datetime, :date, :time
          I18n.l(value, format: :long)
        when :text
          truncate(value, length: 50)
        when :integer
          number_with_delimiter(value)
        else
          value
        end
      end
    end
  end
end
