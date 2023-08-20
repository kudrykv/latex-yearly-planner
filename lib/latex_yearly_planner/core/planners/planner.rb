# frozen_string_literal: true

module LatexYearlyPlanner
  module Core
    module Planners
      class Planner
        def initialize(generator, writer)
          @generator = generator
          @writer = writer
        end

        def generate
          self.tree = generator.generate
        end

        def write
          writer.write(tree)
        end

        def compile
          raise NotImplementedError
        end

        private

        attr_reader :generator, :writer
        attr_accessor :tree
      end
    end
  end
end
