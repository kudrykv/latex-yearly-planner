# frozen_string_literal: true

require "yaml"
require "thor"

require_relative "lyp/version"
require_relative "lyp/cli/app"

require_relative "lyp/handlers/generate"

module LYP
  class Error < StandardError; end
  # Your code goes here...
end
