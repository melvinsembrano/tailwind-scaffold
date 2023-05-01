# frozen_string_literal: true

module Tailwind
  module Scaffold
    class FormBuilder < ActionView::Helpers::FormBuilder

      %i[text_field email_field text_area number_field date_field datetime_field check_box].each do |field_type|
        define_method "tws_#{field_type}" do |method, options = {}|
          @template.render(
            partial: 'tailwind/scaffold/components/input_field',
            locals: { form: self, method:, field_type:, options: }
          )
        end
      end

      def tws_select(method, choices = nil, options = {}, html_options = {}, &block)
        select_options = html_options.merge(class: 'tws__form__select')

        @template.content_tag(:div, class: 'tws__form__panel') do
          [
            label(method, class: 'tws__form__label'),
            @template.content_tag(:div, class: 'tws__form__input') do
              select(method, choices, options, select_options, &block)
            end
          ].join.html_safe
        end
      end

      def tws_errors(errors)
        return if errors.empty?

        @template.render(
          partial: 'tailwind/scaffold/components/form_errors',
          locals: { errors: }
        )
      end

      def tws_submit(options = {})
        @template.content_tag(:div, class: 'tws__form__buttons') do
          [
            @template.content_tag(:a, 'Cancel', class: 'tws__form__cancel_button', href: options[:cancel_url]),
            submit(options.merge(class: 'tws__form__submit_button'))
          ].join.html_safe
        end
      end
    end
  end
end
