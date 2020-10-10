require 'rails_helper'

describe "As A visitor" do
  describe "When I visit a shelter show page" do
    it "I can edit a shelters info" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)
      shelter_3 = create(:shelter)
      shelter_4 = create(:shelter)

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_link("Update Shelter")

      click_link "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      expect(page).to have_field('Name', with: "#{shelter_1.name}")

      fill_in 'Name', with: "Van's Doggo Shelter"

      click_on "Update Shelter"
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Van's Doggo Shelter")
    end
    it "I can see a link to shelters index and pets index and click on them" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)
      visit "/shelters/#{shelter_1.id}/edit"

      click_link "Shelters Index"
      expect(current_path).to eq("/shelters")

      visit "/shelters/#{shelter_1.id}/edit"

      click_link "Pets Index"
      expect(current_path).to eq("/pets")
    end
  end
end
