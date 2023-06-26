# frozen_string_literal: true

class AuthorsController < Tailwind::Scaffold::BaseController
  def resource
    Author
  end

  def show_for_another_date
    { type: :calendar }
  end
end
