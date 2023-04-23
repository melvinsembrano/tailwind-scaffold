# frozen_string_literal: true

require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest

  test 'should get index' do
    get authors_url
    assert_response :success
  end

  test 'should get new' do
    get new_author_url
    assert_response :success
  end

  test 'should create author' do
    assert_difference('Author.count') do
      post authors_url, params: { author: { name: 'Test Author' } }
    end

    assert_redirected_to authors_url
  end

  test 'should show author' do
    get author_url(authors(:one))
    assert_response :success
  end

  test 'should get edit' do
    get edit_author_url(authors(:one))
    assert_response :success
  end

  test 'should update author' do
    patch author_url(authors(:one)), params: { author: { name: 'Test Author' } }
    assert_redirected_to authors_url
  end

  test 'should destroy author' do
    assert_difference('Author.count', -1) do
      delete author_url(authors(:one))
    end

    assert_redirected_to authors_url
  end

end
