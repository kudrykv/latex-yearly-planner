# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeI18n
      include Interactor

      def call
        I18n.load_path = Dir[locales_file_pattern]
        I18n.locale = planner_config.locale
      end

      private

      def locales_file_pattern
        raise DevelopmentError, '`locales_file_pattern` is not defined' unless context.locales_file_pattern

        context.locales_file_pattern
      end

      def planner_config
        raise DevelopmentError, '`planner_config` is not defined' unless context.planner_config

        context.planner_config
      end
    end
  end
end
