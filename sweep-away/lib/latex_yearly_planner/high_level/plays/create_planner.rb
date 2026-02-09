# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Plays
      class CreatePlanner < Actor
        input :planner, allow_nil: false

        def call
          planner.create
        end
      end
    end
  end
end
