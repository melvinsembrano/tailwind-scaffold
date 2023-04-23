module Tailwind
  module Scaffold
    class Engine < ::Rails::Engine
      isolate_namespace Tailwind::Scaffold
    end
  end
end
