# frozen_string_literal: true

class LYP::Services::Generate
  def generate(dto)
    planner = select_planner(dto[:template])

    sections(dto).map do |section|
      next unless section[:enabled]

      planner.generate(dto, section)
    end
  end

  private

  def select_planner(template)
    case template
    when "mos"
      Planners::MOS::Planner.new
    else
      raise ConfigError, "Bad template: #{template}"
    end
  end

  def sections(dto)
    sections = dto.dig(:planner, :sections)
    raise ConfigError, "planner.sections is blank" if sections.nil? || sections.empty?

    sections
  end
end
