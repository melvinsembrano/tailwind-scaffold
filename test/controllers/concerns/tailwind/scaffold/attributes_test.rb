# frozen_string_literal: true

require 'test_helper'

module Tailwind
  module Scaffold
    class AttributesTest < ActiveSupport::TestCase

      setup do
        @controller = AuthorsController.new
      end

      test 'default resource_attributes' do
        assert_equal %i[id name description birthday created_at updated_at], @controller.resource_attributes
      end

      test 'custom resource_attributes' do
        assert_equal %i[title summary published], BooksController.new.resource_attributes
      end

      test 'resource_index_attributes' do
        assert_equal %i[id name description birthday created_at updated_at], @controller.resource_index_attributes
      end

      test 'resource_create_attributes should not have generated attributes' do
        assert_equal %i[name description birthday], @controller.resource_create_attributes
      end

      test 'resource_update_attributes should not have generated attributes' do
        assert_equal %i[name description birthday], @controller.resource_update_attributes
      end

      test 'resource_associations' do
        assert_equal %i[books], AuthorsController.new.resource_associations
      end

      test 'resource_controller' do
        assert_equal BooksController, @controller.resource_controller(AuthorsController, Book)
      end

      test 'resource_index_for' do
        assert_equal(
          { type: :has_many, association: :books, controller: BooksController },
          @controller.resource_index_for(:books)
        )
      end

      test 'resource_route_param' do
        assert_equal({ author_id: 1 }, @controller.resource_route_param(Author.new(id: 1)))
      end

    end
  end
end
