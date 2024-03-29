# frozen_string_literal: true

require 'pagy'

module Tailwind
  module Scaffold
    class BaseController < ::ApplicationController
      include ::Pagy::Backend
      include Tailwind::Scaffold::Attributes
      include Tailwind::Scaffold::Authorisation
      include Tailwind::Scaffold::UrlHelpers
      include Tailwind::Scaffold::NavigationHelpers
      include Tailwind::Scaffold::UserHelpers

      before_action :set_parent
      before_action :set_resource, only: %i[show edit update destroy]
      layout 'tailwind/scaffold/application'

      def index
        @pagy, @resources = pagy scope
      end

      def show
      end

      def new
        @resource = scope.new
      end

      def edit
      end

      def create
        @resource = scope.new(resource_params)

        respond_to do |format|
          if @resource.save
            format.html do
              redirect_to after_resource_create_url(@resource), notice: "#{resource_name} was successfully created."
            end
            format.json { render :show, status: :created, location: @resource }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @resource.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @resource.update(resource_params)
            format.html do
              redirect_to after_resource_update_url(@resource), notice: "#{resource_name} was successfully updated."
            end
            format.json { render :show, status: :ok, location: @resource }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @resource.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @resource.destroy

        respond_to do |format|
          format.html { redirect_to after_resource_destroy_url, notice: "#{resource_name} was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      helper_method :resource, :resource_name, :title, :breadcrumb, :allowed_actions

      def resource
        raise NotImplementedError
      end

      def resource_name
        resource.model_name.name
      end

      def title
        resource.model_name.human.pluralize
      end

      def breadcrumb
        @breadcrumb ||= Tailwind::Scaffold::Breadcrumb.new(self)
      end

      def allowed_actions
        {
          add: true,
          edit: true,
          delete: true,
          show: true,
          index: true
        }
      end

      private

      def set_parent
        @parent = parent
      end

      def parent
        nil
      end

      def scope
        items = if @parent
                  @parent.send(resource_name.plural.to_sym)
                else
                  resource.all
                end

        search(items)
      end

      def search(scope)
        if params[:q].present?
          scope.search(params[:q])
        else
          scope
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_resource
        @resource = if @parent
                      scope.find(params[:id])
                    else
                      resource.find(params[:id])
                    end
      end

      # Only allow a list of trusted parameters through.
      def resource_params
        params.require(resource.model_name.param_key.to_sym).permit(*resource.attribute_names.map(&:to_sym))
      end
    end
  end
end
