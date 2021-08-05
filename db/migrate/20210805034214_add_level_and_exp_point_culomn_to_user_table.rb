class AddLevelAndExpPointCulomnToUserTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :level, :integer, default: 1
    add_column :users, :exp_point, :integer, default: 0
  end
end
