# frozen_string_literal: true

require_relative 'lib/tailwind/scaffold/version'

Gem::Specification.new do |spec|
  spec.name        = 'tailwind-scaffold'
  spec.version     = Tailwind::Scaffold::VERSION
  spec.authors     = ['Melvin Sembrano']
  spec.email       = ['melv@hey.com']
  spec.homepage    = 'https://github.com/melvinsembrano/tailwind-scaffold'
  spec.summary     = 'A Rails plugin that transforms scaffold views to use Tailwind CSS.'
  spec.description = 'A Rails plugin that transforms scaffold views to use Tailwind CSS.'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/melvinsembrano/tailwind-scaffold'
  spec.metadata['changelog_uri'] = 'https://github.com/melvinsembrano/tailwind-scaffold/blob/master/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'pagy', '>= 6.0.3'
  spec.add_dependency 'rails', '>= 7.0.4.3'
  spec.add_dependency 'rails-i18n', '~> 7.0'
end
