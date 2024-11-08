# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Plays
      class InitializeCompiler < Actor
        input :workdir, allow_nil: false
        input :planner_config, allow_nil: false
        output :compiler

        def call
          self.compiler = Adapters::TypstCompiler.new(workdir:, planner_config:)
        end
      end
    end
  end
end
