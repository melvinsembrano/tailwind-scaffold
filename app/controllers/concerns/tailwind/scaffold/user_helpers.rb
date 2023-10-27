# frozen_string_literal: true

module Tailwind
  module Scaffold
    module UserHelpers
      extend ActiveSupport::Concern

      included do
        helper_method :current_user

        def current_user(key = :name)
          {
            name: 'John Doe',
            email: 'test@email.com',
            avatar: 'https://ui-avatars.com/api/?name=Tailwind+Scaffold&size=150'
          }[key]
        end

      end
    end
  end
end
