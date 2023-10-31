
class Activity
    attr_accessor :activity, :type, :participants, :price, :link

    def initialize(activity, type, participants, price, link)
        @activity = activity
        @type = type
        @participants = participants
        @price = price
        @link = link
    end
end