# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Quarterly
          attr_accessor :i18n, :manifest, :quarter

          def initialize(i18n:, manifest:, quarter:)
            self.i18n = i18n
            self.manifest = manifest
            self.quarter = quarter
          end

          def title
            "[#{i18n.t("quarters.long")} #{quarter.number}]"
          end

          def content
            "[here be content (later)]"
          end
        end
      end
    end
  end
end
