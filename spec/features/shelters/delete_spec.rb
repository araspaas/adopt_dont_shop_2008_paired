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
    it "I can delete a shelter from the index page" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)

      visit "/shelters"

      within ".shelter-#{shelter_2.id}" do
        click_link "Delete Shelter"
      end

      expect(page).to_not have_content(shelter_2.name)
    end
    it "I can't delete a shelter that has pets approved for adoption" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      pet = shelter.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      application = user.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application.application_pets.create(pet_id: pet.id)

      visit "/shelters/#{shelter.id}"
      expect(page).to have_link("Delete Shelter")

      visit "/shelters"
      expect(page).to have_link("Delete Shelter")

      visit "admin/applications/#{application.id}"
      within("#pet-application-status-#{pet.id}") do
        click_button "Approve Pet"
      end

      visit "/shelters/#{shelter.id}"
      expect(page).to_not have_link("Delete Shelter")

      visit "/shelters"
      expect(page).to_not have_link("Delete Shelter")
    end
  end
end
