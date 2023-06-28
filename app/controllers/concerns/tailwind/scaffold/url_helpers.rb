# frozen_string_literal: true

module Tailwind
  module Scaffold
    module UrlHelpers
      extend ActiveSupport::Concern

      included do
        helper_method :resource_list_url,
                      :resource_new_url, :resource_url, :resource_edit_url

        def resource_list_url(params = {})
          url_for controller: resource.model_name.plural, action: :index, **params
        end

        def resource_new_url(params = {})
          url_for controller: resource.model_name.plural, action: :new, **params
        end

        def resource_url(resource, params = {})
          if resource.persisted?
            url_for controller: resource.model_name.plural, action: :show, id: resource.id, **params
          else
            url_for controller: resource.model_name.plural, action: :index, **params
          end
        end

        def resource_edit_url(resource, params = {})
          url_for controller: resource.model_name.plural, action: :edit, id: resource.id, **params
        end

        def after_resource_create_url(resource, params = {})
          resource_url(resource, params)
        end

        def after_resource_update_url(resource, params = {})
          resource_url(resource, params)
        end

        def after_resource_destroy_url(params = {})
          resource_list_url(params)
        end

        helper_method :resource_back_url

        def resource_back_url
          resource_list_url
        end

      end
    end
  end
end
