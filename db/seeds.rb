
Wine.destroy_all
User.destroy_all

User.create(email: "john@gmail.com", password: "Bobobobo")

Wine.create(name: "Saint Amour", region: "Bordeaux", year: 2020, price: 10, user_id: 3)
Wine.create(name: "Oiseau blanc", region: "Languedoc", year: 2021, price: 9.90, user_id: 3)
