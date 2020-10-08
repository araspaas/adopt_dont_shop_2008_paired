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
    end
  end
end
