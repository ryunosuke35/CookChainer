class AddTagCategoryRefToTag < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :tag_category, foreign_key: true
  end
end
