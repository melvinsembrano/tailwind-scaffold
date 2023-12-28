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
          <div>
            <form class="flex">

              <label for="search" class="sr-only">Search</label>
              <div class="relative text-gray-400 focus-within:text-gray-600">
                <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                  <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z" clip-rule="evenodd" />
                  </svg>
                </div>
                <input name="q" value="#{options[:q]}" class="block w-full rounded-md border-1 border-tw-300 bg-white py-1 pl-10 pr-3 text-gray-900 focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-tw-600 sm:text-sm sm:leading-6" placeholder="Search" type="search" name="search">
              </div>
            </form>
          </div>
          <div class="mt-4 sm:ml-3 sm:mt-0 sm:flex-none">
            #{if allowed_actions[:add]
                link_to("Add #{title.singularize}", options[:new_path], class: 'tws__table__button')
              end}
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

      def tws_table_panel(&block)
        content_tag(:div, class: 'tws__table__panel') do
          content_tag(:div, class: 'tws__table__panel_a') do
            content_tag(:div, class: 'tws__table__panel_b') do
              block.call
            end
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
        content_tag(:td, class: 'tws__table__cell__actions flex gap-x-4') do
          block.call
        end
      end
    end
  end
end
