class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  belongs_to :tag_category
end
