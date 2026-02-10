# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        module Pages
          class Weekly
            attr_accessor :overseer, :week

            def initialize(overseer:, week:)
              self.overseer = overseer
              self.week = week
            end

            def generate
              week.to_s
            end
          end
        end
      end
    end
  end
end
