# frozen_string_literal: true

require 'English'
module LatexYearlyPlanner
  module Core
    module Planners
      class Planner
        def initialize(generator, writer, compiler)
          @generator = generator
          @writer = writer
          @compiler = compiler
        end

        def generate
          self.tree = generator.generate
        end

        def write
          writer.write(tree)
        end

        def compile
          compiler.compile(writer.index_file)
        end

        private

        attr_reader :generator, :writer, :compiler
        attr_accessor :tree
      end
    end
  end
end
