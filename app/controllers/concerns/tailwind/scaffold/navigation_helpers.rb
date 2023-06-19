# frozen_string_literal: true

module Tailwind
  module Scaffold
    module NavigationHelpers
      extend ActiveSupport::Concern

      included do
        helper_method :navigations

        def navigations
          [
            { name: 'Dashboard', url: '/admin/dashboard', icon: 'layouts/tailwind/scaffold/admin/icons/dashboard' }
          ]
        end

      end
    end
  end
end
