# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeCompiler
      include Interactor

      def call
        context.compiler = Adapters::TeXCompiler.new(workdir:)
      end

      private

      def workdir
        raise DevelopmentError, 'workdir is not defined' unless context.workdir

        context.workdir
      end
    end
  end
end
