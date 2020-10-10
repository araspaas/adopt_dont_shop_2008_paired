require 'rails_helper'

describe "As A visitor" do
  describe "When i visit the shelter index page" do
    describe "I can see a link to create a new shelter" do
      it "when I click this link i'm taken to a form to create a new shelter and can see the created shelter on the index page" do
        shelter_1 = create(:shelter)
        shelter_2 = create(:shelter)
        shelter_3 = create(:shelter)
        shelter_4 = create(:shelter)

        visit '/shelters'

        expect(page).to have_link("New Shelter")

        click_link "New Shelter"

        expect(current_path).to eq("/shelters/new")

        fill_in "Name", with: "Van's Dog Shelter"
        fill_in "Address", with: "3724 Tennessee Dr"
        fill_in "City", with: "Rockford"
        fill_in "State", with: "Illinois"
        fill_in "Zip", with: "61108"
        click_on "Create Shelter"

        expect(current_path).to eq("/shelters")
        expect(page).to have_content("Van's Dog Shelter")
      end
      it "I can see a link to shelters index and pets index and click on them" do
        shelter_1 = create(:shelter)

        pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)
        visit "/shelters/new"

        click_link "Shelters Index"
        expect(current_path).to eq("/shelters")

        visit "/shelters/new"

        click_link "Pets Index"
        expect(current_path).to eq("/pets")
      end
    end
  end
end
