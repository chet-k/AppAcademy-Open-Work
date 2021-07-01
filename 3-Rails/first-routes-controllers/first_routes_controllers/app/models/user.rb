class User < ApplicationRecord
    validates :username, presence: true

    has_many :artworks, foreign_key: :artwork_id, class_name: 'Artworks'
end