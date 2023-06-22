# frozen_string_literal: true

module Tailwind
  module Scaffold
    module ShowHelper

      def tws_show_for(resource, method, options = {})
        render partial: 'tailwind/scaffold/base/show/content_row', locals: { method:, resource:, options: }
      end

      def tws_show(value, options = {})
        case options[:type]
        when :humanize, :enum
          value.humanize
        when :date
          value.strftime('%d/%m/%Y')
        when :datetime
          value.strftime('%d/%m/%Y %H:%M')
        when :boolean
          value ? 'Yes' : 'No'
        when :integer
          number_with_delimiter(value)
        else
          "#{value} #{options}"
        end
      end
    end
  end
end
