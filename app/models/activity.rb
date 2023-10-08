class Activity < ApplicationRecord

    def get_avtivity_index(activity_level)
        activity_index = Activity.where(activity_level: activity_level)
    end
end
