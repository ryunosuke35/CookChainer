class AddSomeColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :profile, :string
    add_column :users, :image, :string
    add_column :users, :public_or_private, :boolean, default: false

  end
end
