# frozen_string_literal: true

require 'test_helper'

module Tailwind
  module Scaffold
    class BreadcrumbTest < ActiveSupport::TestCase
      def request
        @request ||= ActionDispatch::TestRequest.create
      end

      def book_controller
        @book_controller ||= proc do
          controller = BooksController.new
          controller.request = request
          controller
        end.call
      end

      def author_controller
        @author_controller ||= proc do
          controller = AuthorsController.new
          controller.request = request
          controller
        end.call
      end

      test 'crumbs' do
        breadcrumb = Breadcrumb.new(author_controller)
        assert_equal(
          [
            { name: 'Authors', url: 'http://test.host/authors' }
          ],
          breadcrumb.crumbs
        )
      end

      test 'crumbs with resource' do
        author = authors(:one)
        author_controller.instance_variable_set('@resource', author)
        breadcrumb = Breadcrumb.new(author_controller)
        assert_equal(
          [
            { name: 'Authors', url: 'http://test.host/authors' },
            { name: author.name, url: "http://test.host/authors/#{author.id}" }
          ],
          breadcrumb.crumbs
        )
      end

      test 'crumbs with parent' do
        book = books(:one)
        book_controller.instance_variable_set('@parent', book.author)
        breadcrumb = Breadcrumb.new(book_controller)
        assert_equal(
          [
            { name: 'Authors', url: 'http://test.host/authors' },
            { name: book.author.name, url: "http://test.host/authors/#{book.author.id}" },
            { name: 'Books', url: "http://test.host/authors/#{book.author.id}/books" }
          ],
          breadcrumb.crumbs
        )
      end

      test 'crumbs with parent and resource' do
        book = books(:one)
        book_controller.instance_variable_set('@parent', book.author)
        book_controller.instance_variable_set('@resource', book)
        breadcrumb = Breadcrumb.new(book_controller)
        assert_equal(
          [
            { name: 'Authors', url: 'http://test.host/authors' },
            { name: book.author.name, url: "http://test.host/authors/#{book.author.id}" },
            { name: 'Books', url: "http://test.host/authors/#{book.author.id}/books" },
            { name: "Book (#{book.id})", url: "http://test.host/authors/#{book.author.id}/books/#{book.id}" }
          ],
          breadcrumb.crumbs
        )
      end

    end
  end
end
