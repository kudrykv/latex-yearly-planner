# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyReflectBody < Component
          def generate(_day)
            [
              goals_label, hfill, best_thing_label, nl, goals_and_best_thing_notes, nlnl,
              gratitude_label, nl, gratitude_notes, nlnl,
              daily_log_label, nl, daily_log_notes
            ].join
          end

          private

          def goals_label
            XTeX::Label.new(**struct(:goals_label).deep_merge({ parameters: { text: 'Goals' } }))
          end

          def best_thing_label
            XTeX::Label.new(**struct(:best_thing_label).deep_merge({ parameters: { text: 'Today\'s best thing' } }))
          end

          def goals_and_best_thing_notes
            XTeX::Notes.new(**struct(:goals_and_best_thing_notes))
          end

          def gratitude_label
            XTeX::Label.new(**struct(:gratitude_label).deep_merge({ parameters: { text: 'Things I\'m grateful for' } }))
          end

          def gratitude_notes
            XTeX::Notes.new(**struct(:gratitude_notes))
          end

          def daily_log_label
            XTeX::Label.new(**struct(:daily_log_label).deep_merge({ parameters: { text: 'Daily Log' } }))
          end

          def daily_log_notes
            XTeX::Notes.new(**struct(:daily_log_notes))
          end
        end
      end
    end
  end
end
