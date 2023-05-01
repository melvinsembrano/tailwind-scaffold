# frozen_string_literal: true

module Tailwind
  module Scaffold
    module ApplicationHelper
      include ::Pagy::Frontend
      include AttributesHelper
      include FormHelper
      include TableHelper

    end
  end
end
