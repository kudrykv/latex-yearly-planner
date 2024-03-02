# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    class Component < Base
      def generate
        raise NotImplementedError
      end
    end
  end
end
