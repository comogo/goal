module Goal
  class HourCalculator
    def total_days_until(date = Date.current)
      total = 0
      month = Date.current.month
      year  = Date.current.year
      date.day.downto(1) do |day|
        current = Date.new(year, month, day)

        total += 1 unless current.saturday? || current.sunday?
      end

      total
    end

    def estimated_for(goal)
      current_days = total_days_until
      total_days   = total_days_until Date.current.end_of_month

      hours_per_day = goal.to_f / total_days.to_f

      current_days * hours_per_day
    end

    def hour_rate(hours_until_now)
      hours_until_now.to_f / total_days_until.to_f
    end

    def rate_to_goal(goal, hours_until_now)
      (goal - hours_until_now) / days_left
    end

    def days_left
      total_days_until(Date.current.end_of_month) - total_days_until
    end
  end
end
