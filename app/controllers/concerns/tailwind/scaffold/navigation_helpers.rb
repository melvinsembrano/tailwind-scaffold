# frozen_string_literal: true

module Tailwind
  module Scaffold
    module NavigationHelpers
      extend ActiveSupport::Concern

      included do
        helper_method :navigations, :navigation_active?, :app_logo

        def navigations
          [
            { name: 'Dashboard', url: '/admin/dashboard', icon: 'layouts/tailwind/scaffold/admin/icons/dashboard' }
          ]
        end

        def navigation_active?(navigation)
          navigation[:current].present? ? navigation[:current].call : current_page?(navigation[:url])
        end

        def app_logo
          'https://tailwindui.com/img/logos/mark.svg?color=tw&shade=600'
        end

      end
    end
  end
end
