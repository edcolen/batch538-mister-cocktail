class Review < ApplicationRecord
  belongs_to :cocktail

  validates :rating, inclusion: { in: 1.0..5.0 }
end
