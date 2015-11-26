class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  validates :user, uniqueness: { scope: :restaurant, message: "You cannot review a restaurant twice" }
  validates :rating, inclusion: (1..5)
end