class TagCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 1..50 }

  has_many :tags
end
