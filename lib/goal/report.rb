module Goal
  class Report
    def initialize(data, options = {})
      @data = data
      @column_width = options.fetch(:column_width, 8)
    end

    def to_s
      output = row(header) + "\n"

      data[:rows].each do |r|
        output += row([r[:goal], r[:expected], r[:average]]) + "\n"
      end

      output += footer

      output
    end

    private

    attr_reader :data, :column_width

    def header
      %w(Goals Expected Average)
    end

    def footer
      "|" + ('-' * ((column_width * 3) + 8)) + "|\n" +
      "| Current time: #{data[:summary][:total_time]}\n" +
      "| Current rate: #{data[:summary][:rate]}\n" +
      "| Days left:    #{data[:summary][:days_left]}"
    end

    def row(columns)
      prepared_columns = prepare_columns(columns)

      "| #{prepared_columns.join(' | ')} |"
    end

    def prepare_columns(columns)
      columns.map do |c|
        c.to_s.ljust(column_width)
      end
    end
  end
end
