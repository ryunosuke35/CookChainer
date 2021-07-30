class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.text :url
      t.string :memo
      t.text :image

      t.timestamps
    end
  end
end
