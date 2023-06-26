# frozen_string_literal: true

require 'test_helper'

module Tailwind
  module Scaffold
    class ShowTest < ActiveSupport::TestCase

      setup do
        @controller = AuthorsController.new
      end

      test 'resource_show_attributes' do
        assert_equal %i[id name description birthday created_at updated_at], @controller.resource_show_attributes
      end

      test 'resource_show_attributes with custom attributes' do
        assert_equal %i[title summary published], BooksController.new.resource_show_attributes
      end

      test 'show_title' do
        author = authors(:one)
        assert_equal author.name, @controller.show_title(author)
      end

      test 'show_title without name' do
        book = books(:one)
        assert_equal "Book (#{book.id})", @controller.show_title(book)
      end

      test 'show_for_attributes' do
        assert_equal(
          {
            id: { type: :integer },
            name: { type: :humanize },
            description: { type: :raw },
            birthday: { type: :date },
            created_at: { type: :datetime },
            updated_at: { type: :datetime }
          },
          @controller.show_for_attributes
        )
      end

      test 'show_for enum' do
        assert_equal(
          { type: :enum },
         BooksController.new.show_for(:status)
        )
      end

      test 'show_for with custom type' do
        assert_equal(
          { type: :calendar },
          @controller.show_for(:another_date)
        )
      end

    end
  end
end
