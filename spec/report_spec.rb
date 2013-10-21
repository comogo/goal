require 'spec_helper'

describe Goal::Report do
  let(:data) do
    {
      rows: [
        {
          goal: 160,
          expected: 97.39,
          average: 7.78
        },
        {
          goal: 200,
          expected: 121.74,
          average: 12.22
        }
      ],
      summary: {
        total_time: 90.0,
        rate: 6.43,
        days_left: 9
      }
    }
  end

  subject do
    described_class.new(data)
  end

  describe '#to_s' do
    it 'should build the report' do
      report  = "| Goals    | Expected | Average  |\n"
      report += "| 160      | 97.39    | 7.78     |\n"
      report += "| 200      | 121.74   | 12.22    |\n"
      report += "|--------------------------------|\n"
      report += "| Current time: 90.0\n"
      report += "| Current rate: 6.43\n"
      report += "| Days left:    9"

      expect(subject.to_s).to eq report
    end
  end
end
