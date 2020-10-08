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
  end
end
