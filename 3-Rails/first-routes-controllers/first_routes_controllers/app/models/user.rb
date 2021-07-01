class User < ApplicationRecord
    validates :username, presence: true

    has_many :artworks, foreign_key: :artwork_id, class_name: 'Artworks'
    has_many :artwork_shares, foreign_key: :viewer_id
    has_many :shared_artworks, through: :artwork_shares, source: :artwork
end 