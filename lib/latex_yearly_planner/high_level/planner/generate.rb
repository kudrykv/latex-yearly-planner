# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Planner
      class Generate
        include Interactor::Organizer

        organize InitializeConfig,
                 InitializeI18n,
                 InitializeSectioner,
                 InitializeIndexer,
                 InitializeTypstIndexer,
                 InitializeGenerator,
                 InitializeTextDocumentsWriter,
                 InitializeCompiler,
                 InitializeTypstCompiler,
                 InitializePlanner,
                 CreatePlanner
      end
    end
  end
end
