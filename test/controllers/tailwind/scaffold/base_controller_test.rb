# frozen_string_literal: true

require 'test_helper'

module Tailwind
  module Scaffold
    class BaseControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      # test 'should get index' do
      #   get base_index_url
      #   assert_response :success
      # end
    end
  end
end
