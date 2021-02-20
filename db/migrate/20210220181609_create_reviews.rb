class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :cocktail, null: false, foreign_key: true
      t.text :content, default: ''
      t.decimal :rating, default: 0, null: false, precision: 2, scale: 1
      t.integer :likes, default: 0
      t.string :user, default: ''

      t.timestamps
    end
  end
end
