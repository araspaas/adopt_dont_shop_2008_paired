require 'rails_helper'

describe Application, type: :model do
  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end
  describe "instance methods" do
    it "#user_name" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      application = user.applications.create(description: "I'm awesome, give me animals.")

      expect(application.user_name).to eq(user.name)
    end
    it "#full_address" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      application = user.applications.create(description: "I'm awesome, give me animals.")

      expect(application.full_address).to eq("#{user.address}, #{user.city}, #{user.state} #{user.zip}")
    end
    it "#pet_names" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      pet1 = shelter.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      pet2 = shelter.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      pet3 = shelter.pets.create(image: "https://media.wired.com/photos/5cdefb92b86e041493d389df/master/pass/Culture-Grumpy-Cat-487386121.jpg", name: "Mr. Cat", age: "9", sex: "male", description: "Has Russian accent", status: 0)
      pet4 = shelter.pets.create(image: "https://i.dailymail.co.uk/1s/2020/03/20/13/26207684-0-image-a-4_1584711978894.jpg", name: "Frank", age: "3", sex: "male", description: "Danger Noodle", status: 0)
      application = user.applications.create(description: "I'm awesome, give me animals.")
      application.application_pets.create([{pet_id: pet1.id}, {pet_id: pet2.id}, {pet_id: pet3.id}, {pet_id: pet4.id}])

      expect(application.pet_names).to eq([pet1, pet2, pet3, pet4])
    end
    it "#application_approved?" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      pet1 = shelter.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      pet2 = shelter.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      application = user.applications.create(description: "I'm awesome, give me animals.", status: 1)
      app_pet1 = application.application_pets.create(pet_id: pet1.id)
      app_pet2 =application.application_pets.create(pet_id: pet2.id)

      expect(application.application_approved?).to eq(false)

      app_pet1.update(status: 1)

      expect(application.application_approved?).to eq(false)

      app_pet2.update(status: 1)

      expect(application.application_approved?).to eq(true)
    end
    it "#application_rejected?" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      pet1 = shelter.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      pet2 = shelter.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      application = user.applications.create(description: "I'm awesome, give me animals.", status: 1)
      app_pet1 = application.application_pets.create(pet_id: pet1.id)
      app_pet2 =application.application_pets.create(pet_id: pet2.id)

      expect(application.application_rejected?).to eq(false)

      app_pet1.update(status: 1)

      expect(application.application_rejected?).to eq(false)

      app_pet2.update(status: 2)

      expect(application.application_rejected?).to eq(true)
    end
  end
end
