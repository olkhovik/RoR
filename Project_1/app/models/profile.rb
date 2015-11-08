class Profile < ActiveRecord::Base
  belongs_to :user

  #validates :user_id, uniqueness: true валидация на уникальность
  # в случае has_one большого значения не имеет
end
