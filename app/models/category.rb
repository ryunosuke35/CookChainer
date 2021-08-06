class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 1..50 }

  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories
end
