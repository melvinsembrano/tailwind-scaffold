class BooksController < Tailwind::Scaffold::BaseController

  def resource_attributes
    %i[title summary published]
  end

  def resource
    Book
  end

  private

  def parent
    Author.find(params[:author_id])
  end

end
