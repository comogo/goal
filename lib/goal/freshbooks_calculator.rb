require 'ruby-freshbooks'

module Goal
  class FreshbooksCalculator
    include DateHandler

    def initialize(freshbooks_username, token, project_id, start_day)
      @username   = freshbooks_username
      @token      = token
      @project_id = project_id
      @start_day  = start_day
    end

    def hours
      entries_for_month.inject(0) { |sum, entry| sum + entry['hours'].to_f }
    end

    private

    attr_reader :username, :token, :start_day, :project_id

    def entries_for_month
      entries = connection.time_entry.list(
        date_from: start_date(start_day),
        date_to: end_of_period(start_day),
        project_id: project_id,
        per_page: per_page
      )

      if entries.has_key?('time_entries') && entries['time_entries'].has_key?('time_entry')
        if entries['time_entries']['time_entry'].is_a?(Array)
          entries['time_entries']['time_entry']
        else
          [] << entries['time_entries']['time_entry']
        end
      else
        []
      end
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
