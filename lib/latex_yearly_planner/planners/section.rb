# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Section
      attr_reader :name, :header, :body, :section_config, :planner_config

      def initialize(name:, header:, body:, section_config:, planner_config:)
        @name = name
        @header = header
        @body = body
        @section_config = section_config
        @planner_config = planner_config
      end

      def generate
        pages.map(&method(:generate_page)).join(pages_glue)
      end

      private

      def generate_page(...)
        "#{header.generate(...)}#{body.generate(...)}"
      end

      def pages
        raise NotImplementedError
      end

      def pages_glue
        "\n\n"
      end
    end
  end
end
