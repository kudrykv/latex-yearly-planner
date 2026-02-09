# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Plays
      class InitializeSectioner < Actor
        input :planner_config, allow_nil: false
        output :sectioner

        def call
          self.sectioner = Adapters::Sectioner.new(planner_config:)
        end
      end
    end
  end
end
