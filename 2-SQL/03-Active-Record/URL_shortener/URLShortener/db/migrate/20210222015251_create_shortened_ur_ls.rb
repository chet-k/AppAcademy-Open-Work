class CreateShortenedUrLs < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_ur_ls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :user_id

      t.timestamps
    end
  end
end
