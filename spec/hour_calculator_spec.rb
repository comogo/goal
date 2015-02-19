require 'spec_helper'

describe Goal::HourCalculator do
  subject do
    described_class.new(1)
  end

  describe '#total_days_until' do
    it 'should calculate the business days from the beginning of the month until the specified day' do
      Date.stub(today: Date.new(2013, 10, 1))

      expect(subject.total_days_until Date.new(2013, 10, 17)).to eq 13 # Thursday
      expect(subject.total_days_until Date.new(2013, 10, 18)).to eq 14 # Friday
      expect(subject.total_days_until Date.new(2013, 10, 19)).to eq 14 # Saturday
      expect(subject.total_days_until Date.new(2013, 10, 20)).to eq 14 # Sunday
      expect(subject.total_days_until Date.new(2013, 10, 21)).to eq 15 # Monday
    end

    it 'default option should be the current day' do
      Date.stub(today: Date.new(2013, 10, 18))

      expect(subject.total_days_until).to eq 14
    end
  end

  describe '#estimated_for' do
    it 'should calculate the calculate the current total time for goal until today' do
      Date.stub(today: Date.new(2015, 2, 10))

      expect(subject.estimated_for(160)).to eq 50.90909090909091
      expect(subject.estimated_for(200)).to eq 63.63636363636364
    end
  end

  describe '#hour_rate' do
    it 'calculates the hourly rate from a given time and the past days' do
      Date.stub(today: Date.new(2015, 2, 10))

      expect(subject.hour_rate(40)).to eq 5.714285714285714
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

  describe '#hours_to_goal' do
    it 'calculates hours left to goal' do
      Date.stub(today: Date.new(2015, 4, 20))

      expect(subject.hours_to_goal(200, 115.66)).to eq 84.34
    end

    context 'when on the last day of the month' do
      it 'calculates hours left to goal' do
        Date.stub(today: Date.new(2015, 4, 30))

        expect(subject.hours_to_goal(160, 115.66)).to eq 44.34
      end
    end

    context 'when on the first day of the month' do
      it 'calculates the hours left to goal' do
        Date.stub(today: Date.new(2015, 4, 1))

        expect(subject.hours_to_goal(200, 0)).to eq 200
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

      context 'when start day is bigger than today' do
        it 'calculates days left from previous month to now' do
          subject.stub(start_day: 21)
          Date.stub(today: Date.new(2015, 2, 19))

          expect(subject.days_left).to eq 2
        end
      end

      context 'when end of period is on weekend' do
        it "doesn't includes the weekend as business day" do
          subject.stub(start_day: 23)
          Date.stub(today: Date.new(2015, 2, 19))

          expect(subject.days_left).to eq 2
        end
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
