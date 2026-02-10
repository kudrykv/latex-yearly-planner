# frozen_string_literal: true

class LYP::Services::Planners::MOS::Planner
  def generate(_dto, section)
    case section[:name]
    when "weekly"
      puts "weekly!"
    else
      raise ConfigError, "unknown section: #{section[:name]}"
    end
  end
end
