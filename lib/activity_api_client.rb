
require 'net/http'
require 'json'
require_relative 'activity.rb'

class ActivityApiClient
    BASE_URL = 'https://www.boredapi.com/api/activity'

    def self.fetch_random_activity(filters = {})
        uri = URI(BASE_URL)
        uri.query = URI.encode_www_form(filters)
        begin
            response = Net::HTTP.get_response(uri)
            data = JSON.parse(response.body)
            if data['activity']
                Activity.new(data['activity'], data['type'], data['participants'], data['price'], data['link'])
            else
                raise "No activity found for the specified type or filters."
            end
        rescue StandardError => e
            puts "An error occurred: #{e.message}"
            return nil
        end
    end
end
