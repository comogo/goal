module Goal
  class HourCalculator
    def initialize(start_day)
      @start_day = start_day
    end

    def total_days_until(date = Date.today)
      total = 0
      month = Date.today.month
      year  = Date.today.year
      date.day.downto(start_day) do |day|
        current = Date.new(year, month, day)

        total += 1 unless current.saturday? || current.sunday?
      end

      total
    end

    def estimated_for(goal)
      current_days = total_days_until
      total_days   = total_days_until(end_of_period)

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
      total_days_until(end_of_period) - total_days_until + 1
    end

    private

    attr_reader :start_day

    def end_of_period
      Date.new(Date.today.year, Date.today.month, start_day) + 30
    end
  end
end
