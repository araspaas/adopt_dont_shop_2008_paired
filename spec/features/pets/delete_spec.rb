require "rails_helper"

describe "as a visitor" do
  describe "when i visit a pets show page" do
    it "I can delete a pet" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)

      visit "/pets/#{pet1.id}"

      expect(page).to have_link("Delete Pet")

      click_link("Delete Pet")

      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(pet1.name)
    end
    it "If a pet has an approved application on them, the delete links for that pet will no longer be visible" do
      shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      pet = shelter.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      application = user.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application.application_pets.create({pet_id: pet.id})

      visit "/shelters/#{shelter.id}/pets"
      expect(page).to have_link("Delete Pet")

      visit "/pets"
      expect(page).to have_link("Delete Pet")

      visit "/pets/#{pet.id}"
      expect(page).to have_link("Delete Pet")

      application.update(status: 2)
      pet.update(status: 2)

      visit "/shelters/#{shelter.id}/pets"
      expect(page).to_not have_link("Delete Pet")

      visit "/pets"
      expect(page).to_not have_link("Delete Pet")

      visit "/pets/#{pet.id}"
      expect(page).to_not have_link("Delete Pet")
    end
  end
end
