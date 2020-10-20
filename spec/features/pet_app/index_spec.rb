require "rails_helper"

describe "as a visitor" do
  describe "when I visit a pets show page" do
    it "I see a link to view all applications for that pet" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)

      pet1 = shelter1.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      pet2 = shelter2.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)

      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")

      application1 = user1.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application1.application_pets.create([{pet_id: pet1.id}, {pet_id: pet2.id}])
      application2 = user2.applications.create(description: "Just cuz", status: 1)
      application2.application_pets.create([{pet_id: pet1.id}, {pet_id: pet2.id}])

      visit "/pets/#{pet1.id}"

      click_link "Applications for #{pet1.name}"

      expect(current_path).to eq("/pets/#{pet1.id}/applications")

      within "#user-#{user1.id}" do
        click_link "#{user1.name}"
      end

      expect(current_path).to eq("/applications/#{application1.id}")

      visit "/pets/#{pet1.id}"

      click_link "Applications for #{pet1.name}"
      expect(current_path).to eq("/pets/#{pet1.id}/applications")

      within "#user-#{user2.id}" do
        click_link "#{user2.name}"
      end

      expect(current_path).to eq("/applications/#{application2.id}")
    end
    it "will display a message if pet has no application" do
      shelter1 = create(:shelter)

      pet1 = shelter1.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)

      visit "/pets/#{pet1.id}"

      click_link "Applications for #{pet1.name}"

      expect(page).to have_content("#{pet1.name} has no applications. YET!")
    end
  end
end
