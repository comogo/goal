require 'spec_helper'

describe Goal::Base do
  describe '#worked_time' do
    it 'should get the worked_time from freshbooks' do
      freshbooks_instance = double(:freshbooks_instance)

      Goal::FreshbooksCalculator.should_receive(:new).with('username', 'token').and_return(freshbooks_instance)
      freshbooks_instance.should_receive(:hours).and_return(30)

      expect(subject.worked_time('username', 'token')).to eq 30
    end
  end

  describe '#calculate_goal' do
    it 'should calculate goal using the hour calculator' do
      Goal::HourCalculator.any_instance.should_receive(:estimated_for).with(200).and_return 10

      expect(subject.calculate_goal(200)).to eq 10
    end
  end

  describe '#calculate_goals' do
    it 'should calculate goals using the hour calculator' do
      Goal::HourCalculator.any_instance.should_receive(:estimated_for).with(160).and_return 10
      Goal::HourCalculator.any_instance.should_receive(:estimated_for).with(200).and_return 20

      expect(subject.calculate_goals([160, 200])).to eq([
        {
          goal: 160,
          expected: 10
        },
        {
          goal: 200,
          expected: 20
        }
      ])
    end
  end
end
