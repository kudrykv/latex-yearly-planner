# frozen_string_literal: true

module CalendarHelpers
  def make_day(date_str, weekday_start: :monday)
    LYP::Entities::Calendar::Day.new(
      day: Date.parse(date_str),
      weekday_start:
    )
  end

  def make_week(date_str, weekday_start: :monday)
    LYP::Entities::Calendar::Week.new(
      weekday_start:,
      day: make_day(date_str, weekday_start:)
    )
  end

  def make_month(yyyy_mm, weekday_start: :monday)
    LYP::Entities::Calendar::Month.new(
      weekday_start:,
      day: make_day("#{yyyy_mm}-01", weekday_start:)
    )
  end

  def make_quarter(date_str, weekday_start: :monday)
    LYP::Entities::Calendar::Quarter.new(
      weekday_start:,
      day: make_day(date_str, weekday_start:)
    )
  end
end
