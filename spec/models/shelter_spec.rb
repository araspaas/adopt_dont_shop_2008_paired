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
  end
end
