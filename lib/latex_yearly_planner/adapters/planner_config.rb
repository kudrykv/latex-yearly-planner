# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class PlannerConfig
      def initialize(hash)
        @config = RecursiveOpenStruct.new(hash, recurse_over_arrays: true)
      end
    end
  end
end
