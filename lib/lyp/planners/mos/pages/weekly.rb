# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        module Pages
          class Weekly
            attr_accessor :i18n, :overseer, :manifest, :week

            def initialize(i18n:, overseer:, manifest:, week:)
              self.i18n = i18n
              self.overseer = overseer
              self.manifest = manifest
              self.week = week
            end

            def title
              "#{i18n.t("week_name_full")} #{week.number}"
            end

            def content
              "text[weekly content]"
            end
          end
        end
      end
    end
  end
end
