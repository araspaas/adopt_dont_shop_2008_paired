require 'rails_helper'

describe "As a visitor" do
  describe "when i visit shelters index page" do
    it "I can see the name of each shelter" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)
      shelter_3 = create(:shelter)
      shelter_4 = create(:shelter)

      visit "/shelters"

      expect(page).to have_content("#{shelter_1.name}")
      expect(page).to have_content("#{shelter_2.name}")
      expect(page).to have_content("#{shelter_3.name}")
      expect(page).to have_content("#{shelter_4.name}")
    end
  end
end
