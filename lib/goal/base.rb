module Goal
  class Base
    def initialize
      @calculator = HourCalculator.new
    end

    def worked_time(username, token)
      FreshbooksCalculator.new(username, token).hours
    end

    def calculate_goal(goal)
      calculator.estimated_for(goal)
    end

    def calculate_goals(goals)
      calculated_goals = []

      goals.each do |goal|
        calculated_goals.push({
          goal: goal,
          expected: calculate_goal(goal)
        })
      end

      calculated_goals
    end

    private

    attr_reader :calculator
  end
end
