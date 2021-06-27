class AddUsernameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, null: false
  end
end


"""
INSTRUCTIONS:
For the user table you should have name and email columns from the first routes 
project. Change your User model so that you only have one column: username. 
Write new migrations to accomplish this. Enforce presence and uniqueness of 
username at both ActiveRecord and DB levels.
"""