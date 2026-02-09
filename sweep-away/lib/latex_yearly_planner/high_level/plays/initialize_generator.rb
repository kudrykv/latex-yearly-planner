# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Plays
      class InitializeGenerator < Actor
        input :indexer, allow_nil: false
        input :sectioner, allow_nil: false
        output :generator

        def call
          self.generator = Services::Generator.new(indexer:, sectioner:)
        end
      end
    end
  end
end
