# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    class Section < Base
      attr_reader :header, :body

      def initialize(section_name, config, section_config, header, body)
        super(section_name, config, section_config)

        @header = header
        @body = body
      end

      def enabled?
        section_config.enabled || false
      end

      def generate
        NotImplementedError
      end
    end
  end
end
