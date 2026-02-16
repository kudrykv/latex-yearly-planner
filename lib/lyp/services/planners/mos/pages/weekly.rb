# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        module Pages
          class Weekly
            attr_accessor :overseer, :manifest, :week

            def initialize(overseer:, manifest:, week:)
              self.overseer = overseer
              self.manifest = manifest
              self.week = week
            end

            def title
              week.id
            end

            def content
              "weekly content"
            end
          end
        end
      end
    end
  end
end
