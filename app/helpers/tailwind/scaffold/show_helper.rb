# frozen_string_literal: true

module Tailwind
  module Scaffold
    module ShowHelper

      def tws_show_attribute(attribute, resource)
        render partial: 'tailwind/scaffold/base/show/content_row', locals: { attribute: attribute, resource: resource }
      end

    end
  end
end
