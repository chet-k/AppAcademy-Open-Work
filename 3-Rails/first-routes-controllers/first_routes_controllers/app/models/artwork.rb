class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :image_url, presence: true
    validates :artist_id, presence: true

    validates :image_url, uniqueness: true
    validates :title, uniqueness: {scope: :artist_id}

    belongs_to :artist, foreign_key: :artist_id, class_name: 'User'
end