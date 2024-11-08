# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Plays
      class InitializeIndexer < Actor
        input :planner_config, allow_nil: false
        output :indexer

        def call
          self.indexer = Adapters::TypstIndexer.new(planner_config:)
        end
      end
    end
  end
end
