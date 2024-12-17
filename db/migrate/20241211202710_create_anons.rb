class CreateAnons < ActiveRecord::Migration[7.2]
  def change
    create_table :anons do |t|
      t.timestamps
      t.string :title
      t.text :description
    end
  end
end
