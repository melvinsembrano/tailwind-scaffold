class BooksController < Tailwind::Scaffold::BaseController

  def resource_attributes
    %i[title summary published]
  end

  def resource
    Book
  end
end
