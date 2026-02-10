# frozen_string_literal: true

require "yaml"
require "thor"
require "active_support/all"
require "benchmark"

require_relative "lyp/version"
require_relative "lyp/cli/app"

require_relative "lyp/handlers/generate"
require_relative "lyp/services/generate"
require_relative "lyp/services/compile"
require_relative "lyp/services/planners/mos/planner"
require_relative "lyp/services/planners/mos/overseer"
require_relative "lyp/services/planners/mos/sections/weekly"
require_relative "lyp/services/planners/mos/pages/weekly"
require_relative "lyp/entities/calendar/day"
require_relative "lyp/entities/calendar/week"

module LYP
  class Error < StandardError; end

  class InternalError < StandardError; end

  class ConfigError < Error; end
end
