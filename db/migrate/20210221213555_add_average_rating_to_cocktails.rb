class AddAverageRatingToCocktails < ActiveRecord::Migration[6.1]
  def change
    add_column :cocktails, :average_rating, :decimal, precision: 2, scale: 1
  end
end
