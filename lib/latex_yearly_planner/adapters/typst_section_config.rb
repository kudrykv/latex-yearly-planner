# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class TypstSectionConfig
      attr_reader :name, :section_config, :planner_config

      def initialize(name:, section_config:, planner_config:)
        @name = name
        @section_config = section_config
        @planner_config = planner_config
      end

      def enabled?
        section_config[:enabled] || false
      end

      def instantiate
        constant.new(name:, page:, section_config: self)
      end

      def params
        @params ||= ConfigOperator.new(section_config: self)
      end

      private

      def page
        page_constant.new(name:, section_config: self)
      end

      def constant
        "LatexYearlyPlanner::Planners::#{template}::Sections::#{camelized_name}".constantize
      end

      def page_constant
        "LatexYearlyPlanner::Planners::#{template}::Pages::#{camelized_name}".constantize
      end

      def template
        planner_config.template.camelize
      end

      def camelized_name
        name.to_s.camelize
      end
    end
  end
end
