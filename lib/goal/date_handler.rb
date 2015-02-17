module Goal
  module DateHandler
    def start_date(start_day)
      month = Date.today.month

      month -= 1 if start_day > Date.today.day

      Date.new(Date.today.year, month, start_day)
    end

    def end_of_period(start_day)
      start_date(start_day) + 30
    end
  end
end
