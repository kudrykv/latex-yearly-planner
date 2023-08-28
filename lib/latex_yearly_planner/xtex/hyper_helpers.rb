# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    module HyperHelpers
      def target_year(content, year:, page: 1)
        Hyper.new(content, page:, year:).target
      end

      def link_year(content, year:, page: 1)
        Hyper.new(content, page:, year:).link
      end
    end
  end
end
