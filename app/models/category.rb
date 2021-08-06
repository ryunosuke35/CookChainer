class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 1..30 }

  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories
end
