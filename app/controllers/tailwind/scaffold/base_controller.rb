# frozen_string_literal: true
require 'pagy'

module Tailwind
  module Scaffold
    class BaseController < ApplicationController
      include ::Pagy::Backend
      include Tailwind::Scaffold::UrlHelpers
      include Tailwind::Scaffold::Attributes

      before_action :set_resource, only: %i[show edit update destroy]

      def index
        @pagy, @resources = pagy scope
      end

      def show
      end

      def new
        @resource = resource.new
      end

      def edit
      end

      # rubocop:disable Metrics/AbcSize
      def create
        @resource = resource.new(resource_params)

        respond_to do |format|
          if @resource.save
            format.html { redirect_to resource_list_url, notice: "#{resource.name} was successfully created." }
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
            format.html { redirect_to resource_list_url, notice: "#{resource.name} was successfully updated." }
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
          format.html { redirect_to resource_list_url, notice: "#{resource.name} was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      helper_method :resource, :resource_attributes, :resource_index_attributes,
                    :resource_create_attributes, :resource_update_attributes, :resource_form_attributes,
                    :resource_form_attributes_with_type, :form_fields

      def resource
        raise NotImplementedError
      end

      private

      def scope
        resource.all
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_resource
        @resource = resource.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def resource_params
        params.require(resource.model_name.param_key.to_sym).permit(*resource.attribute_names.map(&:to_sym))
      end
    end
  end
end
