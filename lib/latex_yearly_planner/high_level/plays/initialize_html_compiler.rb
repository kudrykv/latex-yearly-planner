# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Plays
      class InitializeHtmlCompiler
        include Interactor

        def call
          context.html_compiler = Adapters::HtmlCompiler.new(workdir:, planner_config:)
        end

        private

        def workdir
          raise DevelopmentError, 'workdir is not defined' unless context.workdir

          context.workdir
        end

        def planner_config
          raise DevelopmentError, 'planner_config is not defined' unless context.planner_config

          context.planner_config
        end
      end
    end
  end
end
