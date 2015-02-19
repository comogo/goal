require 'business_time'

module Goal
  class HourCalculator
    include DateHandler

    def initialize(start_day)
      @start_day = start_day
    end

    def total_days_until(today_date = Date.today)
      start_business_date = start_date(start_day)

      start_business_date.business_days_until(today_date + 1)
    end

    def estimated_for(goal)
      current_business_days   = total_days_until
      total_of_business_days  = total_days_until(end_of_period(start_day))

      hours_per_day = goal.to_f / total_of_business_days.to_f

      current_business_days * hours_per_day
    end

    def hour_rate(hours_until_now)
      return 0 unless total_days_until > 0

      hours_until_now.to_f / total_days_until.to_f
    end

    def rate_to_goal(goal, hours_until_now)
      return 0 unless days_left > 0

      hours_to_goal(goal, hours_until_now) / days_left
    end

    def hours_to_goal(goal, hours_until_now)
      goal - hours_until_now
    end

    def days_left
      total_days_until(end_of_period(start_day)) - total_days_until + 1
    end

    private

    attr_reader :start_day
  end
end
