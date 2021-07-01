class AddIndicesToArtworkShares < ActiveRecord::Migration[6.1]
  def change
    add_index :artwork_shares, :artwork_id
    add_index :artwork_shares, :viewer_id
    add_index :artwork_shares, [:artwork_id, :viewer_id], unique: true
  end
end
