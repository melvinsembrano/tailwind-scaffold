# frozen_string_literal: true

module Tailwind
  module Scaffold
    module Attributes
      module Show
        extend ActiveSupport::Concern

        included do

          helper_method :resource_show_attributes, :show_title

          def resource_show_attributes
            resource_attributes
          end

          def show_title(resource)
            resource.respond_to?(:name) ? resource.name : "#{resource.class.name} ##{resource.id}"
          end

        end

      end
    end
  end
end
