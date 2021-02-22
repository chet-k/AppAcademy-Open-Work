require 'securerandom'

class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, uniqueness: true

    belongs_to :user,
        class_name: :User,
        foreign_key: :user_id,
        primary_key: :id 
    
    has_many :visits,
        class_name: :Visit,
        foreign_key: :short_url_id,
        primary_key: :id
    
    has_many :visitors,
        -> { distinct },
        through: :visits,
        source: :visitor

    def self.create_short_url_for_user!(user, long_url)
        ShortenedUrl.create!(
            user_id: user.id, 
            long_url: long_url, 
            short_url: ShortenedUrl.random_code
        )
    end

    def self.random_code
        out = SecureRandom.urlsafe_base64
        
        while ShortenedUrl.exists?(:short_url => out)
            out = SecureRandom.urlsafe_base64
        end
        
        out
    end

    def num_clicks
        visits.count
    end

    def num_uniques
        visitors.count
    end

    def num_recent_uniques
        visits
            .select('user_id')
            .where('creatd_at > ?', 90.minutes.ago)
            .distinct
            .count
    end
end