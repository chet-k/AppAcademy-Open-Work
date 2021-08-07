class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.references :likeable, polymorphic: true, index: true
      
      t.timestamps
    end
  end
end
