require 'goal/hour_calculator'
require 'goal/freshbooks_calculator'
require 'goal/report'

module Goal
  class Calculator
    def initialize(options = {})
      @calculator = Goal::HourCalculator.new
      @goal_list = options.fetch(:goal_list, [160, 200, 250, 300])
      @username  = options[:username]
      @token     = options[:token]
      @hours     = options[:hours]
    end

    def worked_time
      if hours
        hours
      elsif username && token
        freshbooks.hours
      else
        0
      end.round(2)
    end

    # It calculates the current hour rate
    def rate
      calculator.hour_rate(worked_time).round(2)
    end

    def generate_data
      data = {}

      data[:rows] = goals
      data[:summary] = summary

      data
    end

    private

    attr_reader :base, :calculator, :goal_list, :username, :token, :hours

    def freshbooks
      Goal::FreshbooksCalculator.new(username, token)
    end

    def goals
      calculated_goals = []

      goal_list.each do |goal|
        calculated_goals.push({
          goal: goal,
          expected: calculator.estimated_for(goal).round(2),
          average: calculator.rate_to_goal(goal, worked_time).round(2)
        })
      end

      calculated_goals
    end

    def summary
      {
        total_time: worked_time,
        rate: rate,
        days_left: calculator.days_left
      }
    end
  end
end
