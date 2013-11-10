require 'spec_helper'

describe Goal::Calculator do
  describe '#worked_time' do
    context 'with hours' do
      subject do
        described_class.new(hours: 90)
      end

      it 'should return hours' do
        expect(subject.worked_time).to eq 90
      end
    end

    context 'with hours' do
      subject do
        described_class.new(username: 'username', token: 'token')
      end

      it 'should return the freshbooks hours' do
        instance = double(:instance)

        Goal::FreshbooksCalculator.should_receive(:new).with('username', 'token').and_return(instance)
        instance.should_receive(:hours).and_return 55.55

        expect(subject.worked_time).to eq 55.55
      end
    end
  end

  describe '#rate' do
    subject do
      described_class.new(hours: 90)
    end

    it 'should return calculate the rate' do
      Date.stub(today: Date.new(2013, 10, 20))

      expect(subject.rate).to eq 6.43
    end
  end

  describe '#generate_data' do
    subject do
      described_class.new(hours: 90, goal_list: [160, 200])
    end

    it 'should return the generated data' do
      Date.stub(today: Date.new(2013, 10, 20))

      expect(subject.generate_data).to eq({
        rows: [
          {
            goal: 160,
            expected: 97.39,
            average: 7.0
          },
          {
            goal: 200,
            expected: 121.74,
            average: 11.0
          }
        ],
        summary: {
          total_time: 90.0,
          rate: 6.43,
          days_left: 10
        }
      })
    end
  end
end
