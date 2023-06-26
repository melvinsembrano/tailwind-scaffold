# frozen_string_literal: true

module Tailwind
  module Scaffold
    module TableHelper
      def tws_table_heading(title, options = {})
        options[:description] ||= "List of all #{title.pluralize}"
        raw <<-HTML
        <div class="sm:flex sm:items-center">
          <div class="sm:flex-auto">
            <h1 class="tws__table__title">#{title}</h1>
            <p class="tws__table_description">#{options[:description]}</p>
          </div>
          <div class="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
            #{link_to "Add #{title.singularize}", options[:new_path], class: 'tws__table__button'}
          </div>
        </div>
        HTML
      end

      def tws_assoc_table_heading(title, options = {})
        raw <<-HTML
        <div class="sm:flex sm:items-center">
          <div class="sm:flex-auto">
            <h1 class="tws__table__title">#{title.titleize}</h1>
          </div>
          <div class="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
            #{link_to "Add #{title.singularize}", options[:new_path], class: 'tws__table__button'}
          </div>
        </div>
        HTML
      end

      def tws_table_panel(&)
        content_tag(:div, class: 'tws__table__panel') do
          content_tag(:div, class: 'tws__table__panel_a') do
            content_tag(:div, class: 'tws__table__panel_b', &)
          end
        end
      end

      def tws_table(options = {}, &)
        content_tag(:table, options.merge(class: 'tws__table'), &)
      end

      def tws_table_header(attributes)
        content_tag(:thead, class: 'tws__table__header') do
          content_tag(:tr, class: 'tws__table__row') do
            [
              attributes.map { |k, v| content_tag(:th, format_header_title(k, v), class: 'tws__table__header__cell') },
              content_tag(:th, '', class: 'tws__table__header__cell__actions')
            ].flatten.join.html_safe
          end
        end
      end

      def tws_table_body(collection, &block)
        content_tag(:tbody, class: 'tws__table__body') do
          collection.map do |item|
            content_tag(:tr, class: 'tws__table__row') do
              block.call(item)
            end
          end.join.html_safe
        end
      end

      def tws_table_td(content = nil, &block)
        if block_given?
          content_tag(:td, class: 'tws__table__cell') do
            block.call
          end
        else
          content_tag(:td, content, class: 'tws__table__cell')
        end
      end

      def tws_table_td_actions(&block)
        content_tag(:td, class: 'tws__table__cell__actions') do
          block.call
        end
      end
    end
  end
end
