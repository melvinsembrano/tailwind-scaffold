# frozen_string_literal: true

require 'test_helper'

module Tailwind
  module Scaffold
    class FormTest < ActiveSupport::TestCase

      setup do
        @controller = AuthorsController.new
      end

      test 'resource_form_attributes for new resource' do
        assert_equal @controller.resource_create_attributes, @controller.resource_form_attributes(Author.new)
      end

      test 'resource_form_attributes for existing resource' do
        assert_equal @controller.resource_update_attributes, @controller.resource_form_attributes(authors(:one))
      end

      test 'resource_form_attributes_with_type' do
        assert_equal(
          [%i[name string], %i[description text], %i[birthday date]],
          @controller.resource_form_attributes_with_type(authors(:one))
        )
      end

      test 'form_fields' do
        assert_equal(
          {
            name: { type: :text_field },
            description: { type: :text_area },
            birthday: { type: :date_field }
          },
          @controller.form_fields(authors(:one))
        )
      end

    end
  end
end
