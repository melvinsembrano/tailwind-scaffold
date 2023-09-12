# frozen_string_literal: true

module Tailwind
  module Scaffold
    module NavigationHelpers
      extend ActiveSupport::Concern

      included do
        helper_method :navigations, :navigation_active?

        def navigations
          [
            { name: 'Dashboard', url: '/admin/dashboard', icon: 'layouts/tailwind/scaffold/admin/icons/dashboard' }
          ]
        end

        def navigation_active?(navigation)
          navigation[:current].present? ? navigation[:current].call : current_page?(navigation[:url])
        end

      end
    end
  end
end
