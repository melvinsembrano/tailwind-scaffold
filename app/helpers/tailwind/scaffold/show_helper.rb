# frozen_string_literal: true

module Tailwind
  module Scaffold
    module ShowHelper

      def tws_show_for(resource, method, options = {})
        partial_name = case options[:type]
                       when :has_many
                         'has_many_row'
                       else
                         'content_row'
                       end

        render partial: "tailwind/scaffold/base/show/#{partial_name}", locals: { method:, resource:, options: }
      end

      def tws_show(value, options = {})
        case options[:type]
        when :humanize, :enum
          value&.humanize
        when :raw
          raw(value)
        when :date
          I18n.l(value, format: :default)
        when :datetime
          I18n.l(value, format: :long)
        when :boolean
          value ? 'Yes' : 'No'
        when :integer
          number_with_delimiter(value)
        else
          # "#{value} #{options}"
          value
        end
      end
    end
  end
end
