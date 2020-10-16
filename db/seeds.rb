# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 4.times do
#   FactoryBot.create(:shelter)
# end

shelter1 = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
shelter2 = Shelter.create(name: "Bovice's pet shop", address: "1060 W Addison", city: "Chicago", state: "Illinois", zip: "61109")
shelter3 = Shelter.create(name: "Jared's pet shop", address: "343 Bungie Dr", city: "Littleton", state: "Colorado", zip: "80128")
shelter4 = Shelter.create(name: "Old Greg's pet shop", address: "115 rona st", city: "Denver", state: "Colorado", zip: "80200")

shelter1.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
shelter2.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
shelter3.pets.create(image: "https://media.wired.com/photos/5cdefb92b86e041493d389df/master/pass/Culture-Grumpy-Cat-487386121.jpg", name: "Mr. Cat", age: "9", sex: "male", description: "Has Russian accent", status: 0)
shelter4.pets.create(image: "https://i.dailymail.co.uk/1s/2020/03/20/13/26207684-0-image-a-4_1584711978894.jpg", name: "Frank", age: "3", sex: "male", description: "Danger Noodle", status: 0)

user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
user2 = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")

review1 = user1.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
review2 = user1.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
