require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it { should have_many :pets }
    it { should have_many :reviews }
    it { should have_many(:applications).through(:pets) }
  end

  describe "instance methods" do
    it ".count_pets" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)
      shelter_3 = create(:shelter)
      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)
      pet2 = shelter_1.pets.create!(name: "Mr.Cat", image: "https://media.wired.com/photos/5cdefb92b86e041493d389df/master/pass/Culture-Grumpy-Cat-487386121.jpg", age: "8", sex: "Male", description: "Has Russian Accent", status: 0)
      pet3 = shelter_1.pets.create!(name: "maisy", image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", age: "4", sex: "Female", description: "Stomach on legs", status: 0)
      pet4 = shelter_2.pets.create!(name: "Frank", image: "https://i.dailymail.co.uk/1s/2020/03/20/13/26207684-0-image-a-4_1584711978894.jpg", age: "unkown", sex: "Male", description: "Danger Noodle", status: 0)

      expect(shelter_1.count_pets).to eq(3)
      expect(shelter_2.count_pets).to eq(1)
      expect(shelter_3.count_pets).to eq(0)
    end
    it ".average_review_rating" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user1.reviews.create!({title: "Great Shelter!", rating: "5", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user2.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review3 = user1.reviews.create!({title: "Blah Shelter!", rating: "3", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review4 = user2.reviews.create!({title: "Meh Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter1.id})
      expect(shelter1.average_review_rating).to eq(3.0)
      expect(shelter2.average_review_rating).to eq(2.5)
    end
    it ".app_count" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      shelter3 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      pet1 = shelter1.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      pet2 = shelter2.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      pet3 = shelter1.pets.create(image: "https://media.wired.com/photos/5cdefb92b86e041493d389df/master/pass/Culture-Grumpy-Cat-487386121.jpg", name: "Mr. Cat", age: "9", sex: "male", description: "Has Russian accent", status: 0)
      pet4 = shelter3.pets.create(image: "https://i.dailymail.co.uk/1s/2020/03/20/13/26207684-0-image-a-4_1584711978894.jpg", name: "Frank", age: "3", sex: "male", description: "Danger Noodle", status: 0)
      application1 = user1.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application1.application_pets.create([{pet_id: pet1.id}, {pet_id: pet2.id}])
      application2 = user2.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application2.application_pets.create([{pet_id: pet1.id}, {pet_id: pet3.id}])

      expect(shelter1.app_count).to eq(2)
      expect(shelter2.app_count).to eq(1)
      expect(shelter3.app_count).to eq(0)
    end
    it "#deletable?" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      pet = shelter.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      application = user.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application.application_pets.create(pet_id: pet.id)

      expect(shelter.deletable?).to eq(true)

      application.update(status: 2)

      expect(shelter.deletable?).to eq(false)
    end
  end
end
