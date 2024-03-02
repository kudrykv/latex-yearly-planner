# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Planner
      class Generate
        include Interactor::Organizer

        organize ReadYamlConfigFile
      end
    end
  end
end
