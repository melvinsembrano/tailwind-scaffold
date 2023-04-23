Rails.application.routes.draw do
  mount Tailwind::Scaffold::Engine => "/tailwind-scaffold"
end
