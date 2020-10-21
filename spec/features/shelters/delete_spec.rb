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
    it "shelters with no adopted pets can be deleted, which also deletes any associated pets" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      pet = shelter.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      application = user.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application.application_pets.create(pet_id: pet.id)
      pet_id = pet.id
      shelter_id = shelter.id

      visit "/shelters/#{shelter.id}"

      click_link "Delete Shelter"

      expect(Pet.exists?(pet_id)).to eq(false)
      expect(Shelter.exists?(shelter_id)).to eq(false)
    end
    it "deleting a shelter also deletes its associated reviews" do
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      review1 = user.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter.id})
      review2 = user.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter.id})
      review1_id = review1.id
      review2_id = review2.id

      visit "/shelters/#{shelter.id}"

      click_link "Delete Shelter"

      expect(Review.exists?(review1_id)).to eq(false)
      expect(Review.exists?(review2_id)).to eq(false)
    end
  end
end
