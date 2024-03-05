# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class CreatePlanner
      include Interactor

      def call
        context.planner.create
      end
    end
  end
end
