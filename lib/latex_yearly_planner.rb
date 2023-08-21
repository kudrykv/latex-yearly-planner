# frozen_string_literal: true

require 'zeitwerk'
require 'yaml'
require 'recursive-open-struct'
require 'active_support/all'
require 'English'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  'cli' => 'CLI',
  'xtex' => 'XTeX',
  'tex' => 'TeX'
)

loader.setup

module LatexYearlyPlanner
  class Error < StandardError; end
  # Your code goes here...
end
