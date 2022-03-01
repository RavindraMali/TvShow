class Show < ApplicationRecord
    belongs_to:channel

    acts_as_favoritable


    def self.search(search)
        joins(:channel).where('shows.name like (?) OR channels.name like (?)',"%#{search}%","%#{search}%")
    end
end
