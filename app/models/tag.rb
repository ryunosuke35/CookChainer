class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 1..50 }

  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  belongs_to :tag_category
end
