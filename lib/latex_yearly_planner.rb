# frozen_string_literal: true

require 'zeitwerk'
require 'yaml'
require 'recursive-open-struct'
require 'active_support/all'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  'cli' => 'CLI'
)

loader.setup

module LatexYearlyPlanner
  class Error < StandardError; end
  # Your code goes here...
end
