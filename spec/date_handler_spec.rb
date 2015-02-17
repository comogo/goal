require 'spec_helper'

describe Goal::DateHandler do
  subject do
    new_class = Class.new
    new_class.extend Goal::DateHandler
    new_class
  end

  describe '#start_date' do
    context 'when start day is less than today' do
      it 'returns the start date' do
        Date.stub(today: Date.new(2015, 2, 20))

        expect(subject.start_date(15)).to eq Date.new(2015, 2, 15)
      end
    end

    context 'when start day is bigger than today' do
      it 'returns the start date with last month' do
        Date.stub(today: Date.new(2015, 2, 20))

        expect(subject.start_date(21)).to eq Date.new(2015, 1, 21)
      end
    end

    context 'when start day is same than today' do
      it 'returns today' do
        Date.stub(today: Date.new(2015, 2, 20))

        expect(subject.start_date(20)).to eq Date.new(2015, 2, 20)
      end
    end
  end

  describe '#end_of_period' do
    context 'when start day is less than today' do
      it 'returns the start date plus 30 days' do
        Date.stub(today: Date.new(2015, 3, 20))

        expect(subject.end_of_period(15)).to eq Date.new(2015, 4, 14)
      end
    end

    context 'when start day is bigger than today' do
      it 'returns the start date with last month' do
        Date.stub(today: Date.new(2015, 5, 20))

        expect(subject.end_of_period(21)).to eq Date.new(2015, 5, 21)
      end
    end
  end
end
