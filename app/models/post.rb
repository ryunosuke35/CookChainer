class Post < ApplicationRecord
  
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
end
