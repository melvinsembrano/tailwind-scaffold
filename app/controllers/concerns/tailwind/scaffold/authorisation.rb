module Tailwind
  module Scaffold
    module Authorisation
      extend ActiveSupport::Concern

      included do
        helper_method :can_create?, :can_update?,
          :can_destroy?, :can_read?, :can_list?

        def can_list?
          true
        end

        def can_create?
          true
        end

        def can_read?
          true
        end

        def can_update?
          true
        end

        def can_destroy?
          true
        end

        def unauthorised
          raise 'You are not authorised to view this page'
        end

      end
    end
  end
end
