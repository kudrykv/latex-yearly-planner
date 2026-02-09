# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class Generate < Actor
      play Plays::InitializePlannerConfig,
           Plays::InitializeI18n,
           Plays::InitializeSectioner,
           Plays::InitializeIndexer,
           Plays::InitializeGenerator,
           Plays::InitializeTextDocumentsWriter,
           Plays::InitializeCompiler,
           Plays::InitializePlanner,
           Plays::CreatePlanner
    end
  end
end
