class Review < ApplicationRecord
  belongs_to :cocktail

  validates :rating, inclusion: { in: 1.0..5.0 }

  after_create :update_cocktail_rating

  def update_cocktail_rating
    new_rating = cocktail.reviews.reduce(0.0) { |total, review| review.rating + total } / cocktail.reviews.count
    cocktail.update(average_rating: new_rating.round(1))
  end
end
