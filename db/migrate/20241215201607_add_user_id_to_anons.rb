class AddUserIdToAnons < ActiveRecord::Migration[7.2]
  def change
    add_column :anons, :user_id, :integer
  end
end
