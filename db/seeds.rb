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

quantities = [
  '3 spoons', '150ml', '100ml', '50ml', '2 leaves',
  '2 spoons', 'a bit', '30ml', 'a splash', '80ml'
]

drink_names = [
  'Old Fashioned',
  'Margarita',
  'Cosmopolitan',
  'Negroni',
  'Moscow Mule',
  'Martini',
  'Mojito',
  'Whiskey Sour',
  'French 75',
  'Manhattan',
  'Spritz',
  'Gimlet',
  'Sazerac',
  'Pimm\'s Cup',
  'Mimosa',
  'Paloma',
  'Sidecar',
  'Mint Julep',
  'Daiquiri',
  'Dark & Stormy',
  'Martinez'
]

drinks_urls = [
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/old-fashioned-1592951230.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/margarita-1592951298.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cosmopolitan-1592951320.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/negroni-1592951342.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/moscow-mule-1592951361.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/martini-1592951711.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/mojito-1592951385.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/whiskey-sour-1592951408.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-75-1592951630.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/manhattan-1592951428.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/milano-spritzer-1593008325.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gimlet-1592951479.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/sazerac-1592951496.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/pimms-cup-1592951518.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/mimosa-1592951449.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/paloma-1592951544.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/sidecar-1592951563.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/mint-julep-1592951594.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/daiquiri-1592951739.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/dark-n-stormy-1592951763.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/martinez-1592951796.jpg'
]

drink_names.each_with_index do |name, index|
  cocktail = Cocktail.create!(name: name)
  image = URI.open(drinks_urls[index])
  cocktail.photo.attach(io: image, filename: cocktail.name, content_type: 'image/png')

  puts "Mixing #{cocktail.name}..."
  rand(3..6).times do
    possible_ingredient = Ingredient.all.sample

    possible_ingredient = Ingredient.all.sample while cocktail.ingredients.include?(possible_ingredient)

    Dose.create!(
      cocktail: cocktail,
      ingredient: possible_ingredient,
      description: quantities.sample
    )
  end
end

puts '-----------------------------'
puts 'Writing some reviews...'
puts '-----------------------------'

30.times do
  review = Review.create!(
    cocktail: Cocktail.all.sample,
    content: Faker::ChuckNorris.fact,
    rating: rand(1.0..5.0).round(1),
    user: Faker::GreekPhilosophers.name
  )
  puts "#{review.user} has reviewed #{review.cocktail.name}"
end

30.times do
  review = Review.create!(
    cocktail: Cocktail.all.sample,
    content: Faker::Hipster.paragraph(sentence_count: 2),
    rating: rand(1.0..5.0).round(1),
    user: Faker::Ancient.god
  )
  puts "#{review.user} has reviewed #{review.cocktail.name}"
end

puts '-----------------------------'
puts 'Seed successfully created!'
puts '-----------------------------'
