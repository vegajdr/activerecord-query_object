# frozen_string_literal: true

require_relative 'lib/activerecord/query_object/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord-query_object'
  spec.version       = ActiveRecord::QueryObject::VERSION
  spec.authors       = ['vegajdr']
  spec.email         = ['vegajdr@users.noreply.github.com']

  spec.summary       = 'Convenience query object to compose active record queries'
  spec.description   = 'Allows for the composition of queries which increase reusability'
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata['source_code_uri'] = "TODO: Put your gem's public repo URL here."
  # spec.metadata['changelog_uri'] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency 'activerecord', '>= 3.2'
end
