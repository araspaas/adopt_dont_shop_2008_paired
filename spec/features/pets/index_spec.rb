require 'rails_helper'

describe "As a visitor" do
  describe "when i visit the pets index page" do
    it "I see each pet in the system" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)
      shelter_3 = create(:shelter)
      shelter_4 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)
      pet2 = shelter_2.pets.create!(name: "Mr.Cat", image: "https://media.wired.com/photos/5cdefb92b86e041493d389df/master/pass/Culture-Grumpy-Cat-487386121.jpg", age: "8", sex: "Male", description: "Has Russian Accent", status: 0)
      pet3 = shelter_3.pets.create!(name: "maisy", image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", age: "4", sex: "Female", description: "Stomach on legs", status: 0)
      pet4 = shelter_4.pets.create!(name: "Frank", image: "https://i.dailymail.co.uk/1s/2020/03/20/13/26207684-0-image-a-4_1584711978894.jpg", age: "unkown", sex: "Male", description: "Danger Noodle", status: 0)

      visit "/pets"

      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet1.image)
      expect(page).to have_content(pet1.age)
      expect(page).to have_content(pet1.sex)
      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(pet2.name)
      expect(page).to have_content(pet2.image)
      expect(page).to have_content(pet2.age)
      expect(page).to have_content(pet2.sex)
      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content(pet3.name)
      expect(page).to have_content(pet3.image)
      expect(page).to have_content(pet3.age)
      expect(page).to have_content(pet3.sex)
      expect(page).to have_content(shelter_3.name)
      expect(page).to have_content(pet4.name)
      expect(page).to have_content(pet4.image)
      expect(page).to have_content(pet4.age)
      expect(page).to have_content(pet4.sex)
      expect(page).to have_content(shelter_4.name)
    end
  end
end
