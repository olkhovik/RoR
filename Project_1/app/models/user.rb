class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :profile
  has_many :posts, dependent: :destroy
  has_many :comments

  def owner_of?(object)
    #id == object.user_id || admin?
  end
end
