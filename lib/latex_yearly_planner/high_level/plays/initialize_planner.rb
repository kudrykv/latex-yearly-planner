# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Plays
      class InitializePlanner < Actor
        input :generator, allow_nil: false
        input :text_documents_writer, allow_nil: false
        input :compiler, allow_nil: false
        output :planner

        alias writer text_documents_writer

        def call
          self.planner = Core::Planner.new(generator:, writer:, compiler:)
        end
      end
    end
  end
end
