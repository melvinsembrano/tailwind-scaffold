require 'test_helper'

module Tailwind
  module Scaffold
    class UrlHelpersTest < ActiveSupport::TestCase

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

      test 'resource_list_url' do
        assert_equal 'http://test.host/authors', author_controller.resource_list_url
      end

      test 'resource_list_url with parent' do
        assert_equal 'http://test.host/authors/1/books', book_controller.resource_list_url(author_id: 1)
      end

      test 'resource_new_url' do
        assert_equal 'http://test.host/authors/new', author_controller.resource_new_url
      end

      test 'resource_new_url with parent' do
        assert_equal 'http://test.host/authors/1/books/new', book_controller.resource_new_url(author_id: 1)
      end

      test 'resource_url' do
        author = authors(:one)
        assert_equal "http://test.host/authors/#{author.id}", author_controller.resource_url(author)
      end

      test 'resource_url with parent' do
        book = books(:one)
        assert_equal(
          "http://test.host/authors/#{book.author.id}/books/#{book.id}",
          book_controller.resource_url(book, author_id: book.author.id)
        )
      end

      test 'resource_edit_url' do
        author = authors(:one)
        assert_equal "http://test.host/authors/#{author.id}/edit", author_controller.resource_edit_url(author)
      end

      test 'resource_edit_url with parent' do
        book = books(:one)
        assert_equal(
          "http://test.host/authors/#{book.author.id}/books/#{book.id}/edit",
          book_controller.resource_edit_url(book, author_id: book.author.id)
        )
      end

      test 'after_resource_create_url' do
        author = authors(:one)
        assert_equal "http://test.host/authors/#{author.id}", author_controller.after_resource_create_url(author)
      end

      test 'after_resource_create_url with parent' do
        book = books(:one)
        assert_equal(
          "http://test.host/authors/#{book.author.id}/books/#{book.id}",
          book_controller.after_resource_create_url(book, author_id: book.author.id)
        )
      end

      test 'after_resource_update_url' do
        author = authors(:one)
        assert_equal "http://test.host/authors/#{author.id}", author_controller.after_resource_update_url(author)
      end

      test 'after_resource_update_url with parent' do
        book = books(:one)
        assert_equal(
          "http://test.host/authors/#{book.author.id}/books/#{book.id}",
          book_controller.after_resource_update_url(book, author_id: book.author.id)
        )
      end

      test 'after_resource_destroy_url' do
        assert_equal 'http://test.host/authors', author_controller.after_resource_destroy_url
      end

      test 'after_resource_destroy_url with parent' do
        book = books(:one)
        assert_equal(
          "http://test.host/authors/#{book.author.id}/books",
          book_controller.after_resource_destroy_url(author_id: book.author.id)
        )
      end

    end
  end
end
