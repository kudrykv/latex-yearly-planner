# frozen_string_literal: true

require 'zeitwerk'
require 'yaml'
require 'active_support/all'
require 'English'
require 'thor'
require 'service_actor'
require 'i18n'
require 'erb'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  'cli' => 'CLI'
)

loader.setup

module LatexYearlyPlanner
  class Error < StandardError; end
  class DevelopmentError < Error; end
  class ConfigurationError < Error; end
end
