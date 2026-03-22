# frozen_string_literal: true

require "yaml"
require "thor"
require "active_support/all"
require "benchmark"
require "i18n"
require "forwardable"

require_relative "lyp/version"
require_relative "lyp/cli/app"

require_relative "lyp/handlers/generate"
require_relative "lyp/services/generate"
require_relative "lyp/services/compile"
require_relative "lyp/planners/mos/coordinator"
require_relative "lyp/planners/mos/manifest"
require_relative "lyp/planners/mos/builder"
require_relative "lyp/planners/mos/overseer"
require_relative "lyp/planners/mos/page_spec"
require_relative "lyp/planners/mos/sections/cover_plain"
require_relative "lyp/planners/mos/sections/annual"
require_relative "lyp/planners/mos/sections/quarterly"
require_relative "lyp/planners/mos/sections/monthly"
require_relative "lyp/planners/mos/sections/weekly"
require_relative "lyp/planners/mos/sections/daily"
require_relative "lyp/planners/mos/pages/quarterly"
require_relative "lyp/planners/mos/pages/monthly"
require_relative "lyp/planners/mos/pages/weekly"
require_relative "lyp/planners/mos/pages/daily"
require_relative "lyp/planners/mos/components/months_menu"
require_relative "lyp/planners/mos/components/quarters_menu"
require_relative "lyp/planners/mos/components/daily_schedule"
require_relative "lyp/planners/mos/components/daily_top_priorities"
require_relative "lyp/planners/mos/components/daily_notes"
require_relative "lyp/planners/mos/components/little_calendar"
require_relative "lyp/entities/calendar/day"
require_relative "lyp/entities/calendar/week"
require_relative "lyp/entities/calendar/month"
require_relative "lyp/entities/calendar/quarter"

module LYP
  class Error < StandardError; end

  class InternalError < StandardError; end

  class ConfigError < Error; end
end
