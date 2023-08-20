# frozen_string_literal: true

module LatexYearlyPlanner
  module Core
    module Planners
      class Planner
        attr_reader :generator

        def initialize(generator)
          @generator = generator
        end

        def generate
          raise NotImplementedError
        end

        def write
          raise NotImplementedError
        end

        def compile
          raise NotImplementedError
        end
      end
    end
  end
end
