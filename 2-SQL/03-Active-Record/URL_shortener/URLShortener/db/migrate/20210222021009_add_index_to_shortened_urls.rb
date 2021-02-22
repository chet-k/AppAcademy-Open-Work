class AddIndexToShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :email
    add_index :users, :email, unique: :true
    add_index :shortened_urls, :short_url, unique: :true
  end
end
