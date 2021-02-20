class Review < ApplicationRecord
  belongs_to :cocktail

  validates :rating, presence: true
end
