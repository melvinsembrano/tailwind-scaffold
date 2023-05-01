# frozen_string_literal: true

module Tailwind
  module Scaffold
    module FormHelper
      def tws_form_for(resource, options = {}, &block)
        options[:builder] = Tailwind::Scaffold::FormBuilder
        form_for(resource, options, &block)
      end

      def tws_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &block)
        options[:builder] = Tailwind::Scaffold::FormBuilder
        form_with(model:, scope:, url:, format:, **options, &block)
      end
    end
  end
end
