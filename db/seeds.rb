require 'faker'

Wine.destroy_all
User.destroy_all


# Seed pour la table Wines
region = ['Alsace', 'Bordeaux', 'Bourgogne', 'Champagne', 'Corse', 'Midi', 'Provence', 'Sud-ouest', 'Vallée de la Loire', 'Vallée du Rhône', 'Autre']

# Liste d'adresses à Bordeaux
bordeaux_addresses = [
  '2 Rue Sainte-Catherine, Bordeaux',
  '15 Quai Richelieu, Bordeaux',
  '10 Rue Saint-James, Bordeaux',
  '5 Cours du Chapeau Rouge, Bordeaux',
  '20 Rue Saint-Rémi, Bordeaux',
  '8 Rue des Frères Bonie, Bordeaux',
  '25 Cours Victor Hugo, Bordeaux',
  '12 Rue Sainte-Colombe, Bordeaux',
  '7 Rue du Loup, Bordeaux',
  '18 Cours d Alsace-et-Lorraine, Bordeaux',
  '30 Rue Sainte-Croix, Bordeaux',
  '50 Rue du Loup, Bordeaux',
  '14 Rue Bouffard, Bordeaux',
  '17 Place Fernand Lafargue, Bordeaux',
  '40 Rue du Pas-Saint-Georges, Bordeaux',
  '9 Rue Saint-Joseph, Bordeaux',
  '6 Rue des Ayres, Bordeaux',
  '3 Rue du Pas-Saint-Georges, Bordeaux',
  '11 Rue du Pas-Saint-Georges, Bordeaux',
  '4 Rue du Loup, Bordeaux',
  '19 Cours Pasteur, Bordeaux',
]

image_files = Dir.entries('app/assets/images/avatars').select { |f| f.end_with?('.jpg', '.jpeg', '.png', '.gif') }

# Seed pour la table Users
bordeaux_addresses.each_with_index do |address, index|
  user = User.create!(
    email: "user_#{index}@example.com",
    password: 'password123',
    first_name: "First_#{index}",
    last_name: "Last_#{index}",
    username: "username_#{index}",
    phone_number: "1234567890",
    address: "#{address}, France"
  )

  # Attacher une photo aléatoire à chaque vin
  user = user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/avatars/', image_files[index])), filename: 'image.jpg', content_type: 'image/jpeg')
end

# # Seed pour la table Wines

image_files = Dir.entries('app/assets/images/vins').select { |f| f.end_with?('.jpg', '.jpeg', '.png', '.gif') }

20.times do
  wine = Wine.create!(
    name: Faker::Beer.name,
    region: region.sample,
    domain: Faker::Company.name,
    description: Faker::Lorem.paragraph,
    year: (2010..DateTime.now.year).to_a.sample,
    price: Faker::Commerce.price(range: 10.0..100.0),
    stock_quantity: Faker::Number.between(from: 1, to: 100),
    category: %w[Blanc Rouge Rosé].sample,
    grape_variety: Faker::Beer.hop,
    alcohol_level: Faker::Beer.alcohol,
    user_id: User.pluck(:id).sample,
  )
    # Attacher une photo aléatoire à chaque vin
  wine.photo.attach(io: File.open(Rails.root.join('app/assets/images/vins/', image_files.sample)), filename: 'image.jpg', content_type: 'image/jpeg')
end

50.times do
  Booking.create!(status: 0, wine_id: Wine.pluck(:id).sample, user_id: User.pluck(:id).sample)
end
