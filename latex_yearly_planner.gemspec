# frozen_string_literal: true

require_relative 'lib/latex_yearly_planner/version'

Gem::Specification.new do |spec|
  spec.name = 'latex_yearly_planner'
  spec.version = LatexYearlyPlanner::VERSION
  spec.authors = ['Vitaliy Kudryk']
  spec.email = ['vitaliy@bgnfu7re.me']

  spec.summary = 'Generate LaTeX yearly planner.'
  spec.description = 'Generate LaTeX yearly planner.'
  spec.homepage = 'https://github.com/kudrykv/latex-yearly-planner'
  spec.required_ruby_version = '>= 3.1.3'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/kudrykv/latex-yearly-planner'
  spec.metadata['changelog_uri'] = 'https://github.com/kudrykv/latex-yearly-planner/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'thor'
  spec.add_dependency 'zeitwerk'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
