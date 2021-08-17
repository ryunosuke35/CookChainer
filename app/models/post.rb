class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: { in: 1..100 }
  validates :url, format: {with: /\A#{URI::regexp(%w(http https))}\z/}


  VALID_REGEX = /\A#{URI::regexp(%w(http https))}\z/
  validates :url,
    format: { with: VALID_REGEX }


  belongs_to :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
