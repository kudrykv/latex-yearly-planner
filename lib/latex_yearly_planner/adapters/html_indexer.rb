# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class HtmlIndexer
      attr_reader :planner_config, :i18n, :template

      def initialize(planner_config:, i18n: I18n)
        @planner_config = planner_config
        @i18n = i18n

        @template = ERB.new(File.read('./lib/latex_yearly_planner/erb/index.html.erb'))
      end

      def index(text_documents)
        content = template.result(binding)
        [Entities::TextDocument.new(name: 'index.html', content:)]
      end
    end
  end
end
