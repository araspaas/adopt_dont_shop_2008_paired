require 'rails_helper'

describe "As a visitor" do
  describe "when i visit a shelters show page" do
    it "I can see a specific shelters info" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)
      shelter_3 = create(:shelter)
      shelter_4 = create(:shelter)

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("#{shelter_1.name}")
      expect(page).to have_content("#{shelter_1.address}")
      expect(page).to have_content("#{shelter_1.city}")
      expect(page).to have_content("#{shelter_1.state}")
      expect(page).to have_content("#{shelter_1.zip}")

    end
    it "I can see a link to a shelter pets page" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)

      visit "/shelters/#{shelter_1.id}"

      click_link "Pets"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
    end

    it "I can see a link to shelters index and pets index and click on them" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)
      visit "/shelters/#{shelter_1.id}"

      click_link "Shelters Index"
      expect(current_path).to eq("/shelters")

      visit "/shelters/#{shelter_1.id}"

      click_link "Pets Index"
      expect(current_path).to eq("/pets")
    end
    it "will show average review rating for the shelter" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      review1 = user1.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user2.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review3 = user1.reviews.create!({title: "Blah Shelter!", rating: "3", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review4 = user2.reviews.create!({title: "Meh Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter1.id})

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content("Average shelter Review rating: #{shelter1.average_review_rating}")
    end
    it "will show number of applications for this shelters pets" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")

      pet1 = shelter1.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      pet2 = shelter2.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      pet3 = shelter1.pets.create(image: "https://media.wired.com/photos/5cdefb92b86e041493d389df/master/pass/Culture-Grumpy-Cat-487386121.jpg", name: "Mr. Cat", age: "9", sex: "male", description: "Has Russian accent", status: 0)
      pet4 = shelter2.pets.create(image: "https://i.dailymail.co.uk/1s/2020/03/20/13/26207684-0-image-a-4_1584711978894.jpg", name: "Frank", age: "3", sex: "male", description: "Danger Noodle", status: 0)
      application1 = user1.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application1.application_pets.create([{pet_id: pet1.id}, {pet_id: pet2.id}])
      application2 = user2.applications.create(description: "I'm awesome, give me animals.", status: 1)
      application2.application_pets.create([{pet_id: pet1.id}, {pet_id: pet3.id}])

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content("Applications for pets: #{shelter1.app_count}")
    end
    it "can count the number of pets for a specific shelter" do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)
      shelter_3 = create(:shelter)
      pet1 = shelter_1.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      pet2 = shelter_2.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      pet3 = shelter_1.pets.create(image: "https://media.wired.com/photos/5cdefb92b86e041493d389df/master/pass/Culture-Grumpy-Cat-487386121.jpg", name: "Mr. Cat", age: "9", sex: "male", description: "Has Russian accent", status: 0)
      pet4 = shelter_3.pets.create(image: "https://i.dailymail.co.uk/1s/2020/03/20/13/26207684-0-image-a-4_1584711978894.jpg", name: "Frank", age: "3", sex: "male", description: "Danger Noodle", status: 0)

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_content("Pets in this shelter: #{shelter_1.count_pets}")

      visit "/shelters/#{shelter_2.id}"
      expect(page).to have_content("Pets in this shelter: #{shelter_2.count_pets}")

      visit "/shelters/#{shelter_3.id}"
      expect(page).to have_content("Pets in this shelter: #{shelter_3.count_pets}")
    end
  end
end
