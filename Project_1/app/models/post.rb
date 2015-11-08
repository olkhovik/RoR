class Post < ActiveRecord::Base
  # has_and_belongs_to_many :categories

  has_many :comments
  has_many :categories_posts
  has_many :categories, through: :categories_posts
  has_many :tags_posts
  has_many :tags, through: :tags_posts
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
