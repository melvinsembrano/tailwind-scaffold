# frozen_string_literal: true

class TailwindScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  class_option :skip_routes, type: :boolean, desc: "Don't add routes to config/routes.rb."

  def copy_controller_file
    template 'controller.rb', File.join('app/controllers', class_path, "#{file_name.pluralize}_controller.rb")
  end

  def add_routes
    return if options[:skip_routes]

    route "resources :#{file_name.pluralize}", namespace: regular_class_path
  end

end
