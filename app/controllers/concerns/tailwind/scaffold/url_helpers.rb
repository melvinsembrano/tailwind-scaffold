# frozen_string_literal: true

module Tailwind
  module Scaffold
    module UrlHelpers
      extend ActiveSupport::Concern

      included do
        helper_method :resource_list_url,
                      :resource_new_url, :resource_url, :resource_edit_url

        def resource_list_url
          url_for controller: resource.model_name.plural, action: :index
        end

        def resource_new_url
          url_for controller: resource.model_name.plural, action: :new
        end

        def resource_url(resource)
          if resource.persisted?
            url_for controller: resource.model_name.plural, action: :show, id: resource.id
          else
            url_for controller: resource.model_name.plural, action: :index
          end
        end

        def resource_edit_url(resource)
          url_for controller: resource.model_name.plural, action: :edit, id: resource.id
        end

        def after_resource_create_url(resource)
          resource_url(resource)
        end

        def after_resource_update_url(resource)
          resource_url(resource)
        end

        def after_resource_destroy_url
          resource_list_url
        end

      end
    end
  end
end
