require_relative 'activity_api_client.rb'

class CLIController
    ACTIVITY_TYPES = [
        "education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"
    ]

    def call
        intro_message
        loop do
            filters = user_filters
            activity_instance = ActivityApiClient.fetch_random_activity(filters)
            
            if activity_instance.nil?
                puts "Sorry, we couldn't find an activity for your specified criteria. Please try different filters or try again later."
            else
                display_activity(activity_instance)
            end

            puts "\nWould you like to find another activity? (y/n)"
            user_input = gets.chomp.downcase

            break if user_input != 'y'
        end
    end

    def intro_message
        puts "Feeling bored? Let me help you find something to do!"
    end

    def user_filters
        filters = {}
        
        puts "\nSelect a type of activity from the list below:"
        ACTIVITY_TYPES.each_with_index do |activity_type, index|
            puts "#{index + 1}. #{activity_type.capitalize}"
        end
        puts "#{ACTIVITY_TYPES.length + 1}. Skip"
        
        choice = gets.chomp.to_i
        
        if choice.between?(1, ACTIVITY_TYPES.length)
            filters["type"] = ACTIVITY_TYPES[choice - 1]
        end


        return filters
    end

    def display_activity(activity)
        puts "\nActivity: #{activity.activity}"
        puts "Type: #{activity.type}"
        puts "Participants: #{activity.participants}"
        puts "Price: #{activity.price}"
        puts "Link: #{activity.link}" unless activity.link.empty?
    end
end
