require 'faker'

url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_list = open(url).read
ingredients = JSON.parse(ingredients_list)

puts '-----------------------------'
puts 'Creating ingredients...'
puts '-----------------------------'

ingredients['drinks'].each do |ingredient|
  created_ingredient = Ingredient.create!(name: ingredient['strIngredient1'])
  puts "#{created_ingredient.name} created"
end

Ingredient.create!(name: 'Cachaça')
puts 'Cachaça created'

puts '-----------------------------'
puts 'Mixing some drinks...'
puts '-----------------------------'

quantities = ['3 spoons', '200ml', '100ml', '50ml', '2 leaves', '2 spoons', 'a bit of']

20.times do
  cocktail = Cocktail.create!(name: Faker::Coffee.unique.blend_name)
  rand(1..5).times do
    Dose.create!(
      cocktail: cocktail,
      ingredient: Ingredient.all.sample,
      description: quantities.sample
    )
  end

  puts "#{cocktail.name} created"
end

puts '-----------------------------'
puts 'Writing some reviews...'
puts '-----------------------------'

50.times do
  review = Review.create!(
    cocktail: Cocktail.all.sample,
    content: Faker::Hipster.paragraph,
    rating: rand(1.0..5.0).round(1),
    user: Faker::GreekPhilosophers.name
  )
  puts "#{review.user} has reviewed #{review.cocktail.name}"
end

puts '-----------------------------'
puts 'Seed successfully created!'
puts '-----------------------------'
