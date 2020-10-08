require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelters show page" do
    it "I can delete that shelter" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)
      shelter_3 = create(:shelter)
      shelter_4 = create(:shelter)

      visit "/shelters/#{shelter_1.id}"

      click_link "Delete Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(shelter_1.name)
    end
  end
end
