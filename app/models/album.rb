class Album < ApplicationRecord
    validates :title, :year, :band, presence: true

    # Can't user presence validation with boolean field
    validates :is_live, inclusion: { in: [true, false] }
    
    belongs_to :band
end
