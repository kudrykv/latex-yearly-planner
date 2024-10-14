# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class TypstIndexer
      attr_reader :planner_config, :i18n, :template

      def initialize(planner_config:, i18n: I18n)
        @planner_config = planner_config
        @i18n = i18n

        @template = ERB.new(File.read('./lib/latex_yearly_planner/erb/index.typ.erb'))
      end

      # `binding` uses the current scope to get the variables
      #noinspection RubyUnusedLocalVariable
      def index(text_documents)
        content = template.result(binding)
        [Entities::TextDocument.new(name: 'index.typ', content:)]
      end
    end
  end
end
