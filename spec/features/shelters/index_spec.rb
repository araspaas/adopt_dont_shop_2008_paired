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

    it "I can see a link to a shelters edit form and use it" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)

      visit "/shelters"

      within ".shelter-#{shelter_1.id}" do
        click_link "Update Shelter"
      end
      expect(page).to have_field('Name', with: "#{shelter_1.name}")

      fill_in 'Name', with: "Van's Doggo Shelter"

      click_on "Update Shelter"
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Van's Doggo Shelter")

      visit "/shelters"

      within ".shelter-#{shelter_2.id}" do
        click_link "Update Shelter"
      end
      expect(page).to have_field('Name', with: "#{shelter_2.name}")

      fill_in 'Name', with: "Van's catto Shelter"

      click_on "Update Shelter"
      expect(current_path).to eq("/shelters/#{shelter_2.id}")
      expect(page).to have_content("Van's catto Shelter")
    end
    it "I can click on the shelters name and take me to its show page" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)

      visit "/shelters"

      within ".shelter-#{shelter_2.id}" do
        click_link "#{shelter_2.name}"
      end
      expect(current_path).to eq("/shelters/#{shelter_2.id}")

      visit "/shelters"

      within ".shelter-#{shelter_1.id}" do
        click_link "#{shelter_1.name}"
      end
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
    end
  end
end
