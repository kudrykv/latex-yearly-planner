# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class DailyReflect < Section
          def generate
            pages = all_days.map { |day| "#{header.generate(day)}#{body.generate(day)}" }

            Core::Entities::Note.new('daily_reflect', "#{pages.join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}")
          end
        end
      end
    end
  end
end
