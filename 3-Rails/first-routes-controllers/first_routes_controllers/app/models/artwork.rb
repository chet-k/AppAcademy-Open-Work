class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :image_url, presence: true
    validates :image_url, uniqueness: true
    validates :title, uniqueness: {scope: :artist_id}

    belongs_to :artist, foreign_key: :artist_id, class_name: 'User'
    # validates :artist_id, presence: true # rails automatically does this for belongs_to

    has_many :artwork_shares
    has_many :shared_viewers, through: :artwork_shares, source: :viewer
    has_many :likes, as: :likeable
    has_many :comments, dependent: :destroy
    has_many :artwork_collections
    
    def self.artworks_for_user_id(user_id)
        Artwork
            .left_outer_joins(:artwork_shares)
            .where('(artworks.artist_id = :user_id) OR (artwork_shares.viewer_id = :user_id)', user_id: user_id)
            .distinct
    end

    def self.artworks_for_collection_id(collection_id)
        Artwork
            .joins(:artwork_collections)
            .where(artwork_collections: {collection_id: collection_id})
    end
end