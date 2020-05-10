class Track < ApplicationRecord
    validates :album_id, :title, :order, presence: true

    # Can't use presence validation with boolean field
    validates :is_bonus, inclusion: { in: [true, false ] }

    belongs_to :album

end

