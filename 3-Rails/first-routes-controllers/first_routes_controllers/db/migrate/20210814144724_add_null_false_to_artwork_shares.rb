class AddNullFalseToArtworkShares < ActiveRecord::Migration[6.1]
  def change
    change_column_null :artwork_shares, :artwork_id, false
    change_column_null :artwork_shares, :viewer_id, false
  end
end
