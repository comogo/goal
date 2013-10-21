require 'spec_helper'

describe Goal::FreshbooksCalculator do
  let(:time_entry) { double(:time_entry) }
  let(:connection) { double(:connection, time_entry: time_entry) }
  let(:end_of_month) { Date.new Date.today.year, Date.today.month, -1 }
  let(:begin_of_month) { Date.new Date.today.year, Date.today.month, 1 }

  let :entries do
    {
      'time_entries' => {
        'time_entry' => [
          {
            'hours' => '10.5'
          },
          {
            'hours' => '5.4'
          }
        ]
      }
    }
  end

  let :error_entries do
    {
      message: 'error',
      code: '12345'
    }
  end

  subject do
    described_class.new 'username', 'token'
  end

  describe '#hours' do
    context 'when has entries' do
      it 'should be the sum of entry hours' do
        FreshBooks::Client.should_receive(:new).with('username.freshbooks.com', 'token').and_return(connection)
        time_entry.
          should_receive(:list).
          with(date_from: begin_of_month, date_to: end_of_month, per_page: 1000).
          and_return(entries)

        expect(subject.hours).to eq 15.9
      end
    end

    context 'when has no entries' do
      it 'should be 0' do
        FreshBooks::Client.should_receive(:new).with('username.freshbooks.com', 'token').and_return(connection)
        time_entry.
          should_receive(:list).
          with(date_from: begin_of_month, date_to: end_of_month, per_page: 1000).
          and_return(error_entries)

        expect(subject.hours).to eq 0
      end
    end
  end
end
