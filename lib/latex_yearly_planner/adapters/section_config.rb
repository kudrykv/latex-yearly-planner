# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class SectionConfig
      attr_reader :name, :config

      def initialize(name:, config:)
        @name = name
        @config = config
      end
    end
  end
end
