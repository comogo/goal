module Goal
  class Report
    def initialize(data, options = {})
      @data = data
      @column_width = options.fetch(:column_width, 9)
    end

    def to_s
      output = row(header) + "\n"

      data[:rows].each do |r|
        output += row([r[:goal], r[:expected], r[:average], r[:hours_left]]) + "\n"
      end

      output += footer

      output
    end

    private

    attr_reader :data, :column_width

    def header
      %w(Goals Expected Average Left)
    end

    def footer
      summary =  "|" + ('-' * ((column_width * 5) + 2)) + "|\n"
      summary += "| Current time:  #{data[:summary][:total_time]}\n"

      if data[:summary][:money]
        summary += "| Current money: #{number_to_currency(data[:summary][:money])}\n"
      end

      summary += "| Current rate:  #{data[:summary][:rate]}\n"
      summary += "| Days left:     #{data[:summary][:days_left]}"

      summary
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

    def number_to_currency(value)
      val_str = ("%.2f" % [value.to_s]).gsub('.', ',')

      while val_str.sub!(/(\d+)(\d\d\d)/, '\1.\2'); end

      val_str
    end
  end
end
