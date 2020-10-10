require 'rails_helper'

describe "as a visitor" do
  describe "when i visit a pets show page" do
    it "I can see that pets info" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)

      visit "/pets/#{pet1.id}"

      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet1.description)
      expect(page).to have_content(pet1.age)
      expect(page).to have_content(pet1.sex)
      expect(page).to have_content(pet1.status)
    end
    it "I can see a link to shelters index and pets index and click on them" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)
      visit "/pets/#{pet1.id}"

      click_link "Shelters Index"
      expect(current_path).to eq("/shelters")

      visit "/pets/#{pet1.id}"

      click_link "Pets Index"
      expect(current_path).to eq("/pets")
    end
  end
end
