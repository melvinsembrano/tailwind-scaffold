module Tailwind
  module Scaffold
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
