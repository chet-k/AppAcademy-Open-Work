class ShortenedUrl
    validates :long_url, presence: true
    validates :short_url, uniqueness: true
end