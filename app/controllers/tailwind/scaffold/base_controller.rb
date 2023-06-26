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

      # rubocop:disable Metrics/AbcSize
      def create
        @resource = scope.new(resource_params)

        respond_to do |format|
          if @resource.save
            format.html do
              redirect_to after_resource_create_url(@resource), notice: "#{resource.name} was successfully created."
            end
            format.json { render :show, status: :created, location: @resource }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @resource.errors, status: :unprocessable_entity }
          end
        end
      end
      # rubocop:enable Metrics/AbcSize

      def update
        respond_to do |format|
          if @resource.update(resource_params)
            format.html do
              redirect_to after_resource_update_url(@resource), notice: "#{resource.name} was successfully updated."
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
          format.html { redirect_to after_resource_destroy_url, notice: "#{resource.name} was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      helper_method :resource, :title, :breadcrumb

      def resource
        raise NotImplementedError
      end

      def title
        resource.model_name.human.pluralize
      end

      def breadcrumb
        @breadcrumb ||= Tailwind::Scaffold::Breadcrumb.new(self)
      end

      private

      def set_parent
        @parent = parent
      end

      def parent
        nil
      end

      def scope
        if @parent
          @parent.send(resource.model_name.plural.to_sym)
        else
          resource.all
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
