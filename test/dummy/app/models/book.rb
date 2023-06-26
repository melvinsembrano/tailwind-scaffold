class Book < ApplicationRecord
  belongs_to :author
  enum status: { draft: 0, published: 1 }
end
