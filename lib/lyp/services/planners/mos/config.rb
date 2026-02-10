# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Config
          attr_accessor :dto

          def initialize(dto)
            self.dto = dto
          end
        end
      end
    end
  end
end
