class Post < ActiveRecord::Base
  # has_and_belongs_to_many :categories

  has_many :comments, dependent: :destroy
  has_many :categories_posts, dependent: :destroy
  has_many :categories, through: :categories_posts
  has_many :tags_posts, dependent: :destroy
  has_many :tags, through: :tags_posts
  belongs_to :user
  has_many :subscriptions
  has_many :subscribers,
           source: :user, through: :subscriptions

  validates :title, presence: true
  validates :body, presence: true
  enum status: [ :draft, :moderation, :published ]

  after_create :subscribe_author

  scope :reverse_order, -> {order(created_at: :desc)}

  scope :drafts, -> { where(status: [0, 1]) }


def categories_titles
    categories.pluck(:title).join(', ')
 end

 protected

  def subscribe_author
    user.subscribe_to(self)
  end

end
