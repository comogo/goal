require 'spec_helper'

describe Goal::HourCalculator do
  describe '#total_days_until' do
    it 'should calculate the business days from the beginning of the month until the specified day' do
      Date.stub(today: Date.new(2013, 10, 1))

      expect(subject.total_days_until Date.new(2013, 10, 17)).to eq 13 # Thursday
      expect(subject.total_days_until Date.new(2013, 10, 18)).to eq 14 # Friday
      expect(subject.total_days_until Date.new(2013, 10, 19)).to eq 14 # Saturday
      expect(subject.total_days_until Date.new(2013, 10, 20)).to eq 14 # Sunday
      expect(subject.total_days_until Date.new(2013, 10, 21)).to eq 15 # Monday
    end

    it 'it default option should be the current day' do
      Date.stub(today: Date.new(2013, 10, 18))

      expect(subject.total_days_until).to eq 14
    end
  end

  describe '#estimated_for' do
    it 'should calculate the calculate the current total time for goal until today' do
      Date.stub(today: Date.new(2013, 10, 18))

      expect(subject.estimated_for(160)).to eq 97.39130434782608
      expect(subject.estimated_for(200)).to eq 121.7391304347826
    end
  end

  describe '#hour_rate' do
    it 'should calculate the hour rate from a given time and the past days' do
      Date.stub(today: Date.new(2013, 10, 18))

      expect(subject.hour_rate(95)).to eq 6.785714285714286
    end

    context 'when on the last day of the month' do
      it 'should calculate the hour rate' do
        Date.stub(today: Date.new(2013, 10, 31))

        expect(subject.hour_rate(200)).to eq 8.695652173913043
      end
    end

    context 'when on the first day of the month' do
      it 'should calculate the hour rate' do
        Date.stub(today: Date.new(2013, 10, 1))

        expect(subject.hour_rate(0)).to eq 0.0
        expect(subject.hour_rate(5)).to eq 5.0
      end
    end
  end

  describe '#rate_to_goal' do
    it 'should calculate the hour per day needed to the goal from the left days of the month' do
      Date.stub(today: Date.new(2013, 10, 18))

      expect(subject.rate_to_goal(200, 115.66)).to eq 8.434000000000001
    end

    context 'when on the last day of the month' do
      it 'should calculate rate_to_goal' do
        Date.stub(today: Date.new(2013, 10, 31))

        expect(subject.rate_to_goal(200, 115.66)).to eq 84.34
      end
    end

    context 'when on the first day of the month' do
      it 'should calculate the rate to goal' do
        Date.stub(today: Date.new(2013, 10, 1))

        expect(subject.rate_to_goal(200, 0)).to eq 8.0
      end
    end
  end

  describe '#days_left' do
    context 'when in beginning of the month' do
      it 'should return the days left from de month since today' do
        Date.stub(today: Date.new(2013, 10, 1))

        expect(subject.days_left).to eq 23
      end
    end

    context 'when in middle of the month' do
      it 'should return the days left from de month since today' do
        Date.stub(today: Date.new(2013, 10, 18))

        expect(subject.days_left).to eq 10
      end
    end

    context 'when in the end of the month' do
      it 'should return the days left from de month since today' do
        Date.stub(today: Date.new(2013, 10, 31))

        expect(subject.days_left).to eq 1
      end
    end
  end
end
