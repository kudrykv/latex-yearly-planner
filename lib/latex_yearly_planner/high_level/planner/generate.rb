# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Planner
      class Generate
        include Interactor::Organizer

        organize
      end
    end
  end
end
