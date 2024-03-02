# frozen_string_literal: true

require 'zeitwerk'
require 'yaml'
require 'recursive-open-struct'
require 'active_support/all'
require 'English'
require 'ruby-measurement'
require 'thor'
require 'interactor'
require 'i18n'
require 'erb'

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/latex_yearly_planner_old")
loader.inflector.inflect(
  'cli' => 'CLI',
  'xtex' => 'XTeX',
  'tex' => 'TeX'
)

loader.setup

module LatexYearlyPlanner
  class Error < StandardError; end
  class DevelopmentError < Error; end
  class ConfigurationError < Error; end
end
