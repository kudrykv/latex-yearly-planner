# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class DailyNotes < Section
          def generate
            pages = all_days.map do |day|
              pages_number.times.map(&:succ).map { |page| "#{header.generate(page, day)}#{body.generate(page, day)}" }
            end.flatten

            Core::Entities::Note.new('daily_notes', "#{pages.join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}")
          end

          private

          def pages_number
            param(:pages) || 1
          end
        end
      end
    end
  end
end
