# frozen_string_literal: true

require 'pagy'

module Tailwind
  module Scaffold
    module ApplicationHelper
      include ::Pagy::Frontend
      include AttributesHelper
      include FormHelper
      include TableHelper
      include ShowHelper

    end
  end
end
