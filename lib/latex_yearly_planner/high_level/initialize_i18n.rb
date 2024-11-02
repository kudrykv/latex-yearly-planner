# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeI18n < Actor
      input :planner_config, allow_nil: false
      input :locales_file_pattern, allow_nil: false

      def call
        I18n.load_path = Dir[locales_file_pattern]
        I18n.locale = planner_config.locale
      end
    end
  end
end
