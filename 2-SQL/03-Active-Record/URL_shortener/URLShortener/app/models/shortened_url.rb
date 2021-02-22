require 'securerandom'

class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, uniqueness: true

    belongs_to :submitter,
        class_name: :User,
        foreign_key: :user_id,
        primary_key: :id 
    
    has_many :visitors,
        class_name: :User,
        foreign_key: :user_id,
        primary_key: :id

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
end