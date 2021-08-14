class  ArtworkShare < ApplicationRecord
    validates :artwork_id, presence: true, uniqueness: {scope: :viewer_id}
    # validates :favorite, presence: true, inclusion: {in: [true, false]}

    belongs_to :artwork
    belongs_to :viewer, class_name: 'User'
end