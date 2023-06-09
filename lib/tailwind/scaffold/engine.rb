# frozen_string_literal: true

module Tailwind
  module Scaffold
    class Engine < ::Rails::Engine
      isolate_namespace Tailwind::Scaffold

      initializer 'tailwind-scaffold.assets.precompile' do |app|
        app.config.assets.precompile += %w[
          tailwind-scaffold/application.css
        ]

      end

      ActiveSupport.on_load(:action_view) do
        include Tailwind::Scaffold::ApplicationHelper
      end

    end
  end
end
