require 'ruby-freshbooks'

module Goal
  class FreshbooksCalculator
    def initialize(freshbooks_username, token)
      @username = freshbooks_username
      @token    = token
    end

    def hours
      entries_for_month.inject(0) { |sum, entry| sum + entry['hours'].to_f }
    end

    private

    attr_reader :username, :token

    def entries_for_month
      entries = connection.time_entry.list(date_from: date_from, date_to: date_to, per_page: per_page)

      if entries.has_key?('time_entries')
        entries['time_entries']['time_entry']
      else
        []
      end
    end

    def date_from
      Date.new Date.today.year, Date.today.month, 1
    end

    def date_to
      Date.new Date.today.year, Date.today.month, -1
    end

    def per_page
      1000
    end

    def client_url
      "#{username}.freshbooks.com"
    end

    def connection
      @connection ||= FreshBooks::Client.new(client_url, token)
    end
  end
end
