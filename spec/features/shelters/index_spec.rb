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
    it "I can see a link to shelters index and pets index and click on them" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)
      visit "/shelters"

      click_link "Shelters Index"
      expect(current_path).to eq("/shelters")

      visit "/shelters"

      click_link "Pets Index"
      expect(current_path).to eq("/pets")
    end
    it "I see the top 3 highest rated shelters hilighted on a specific part of the page" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      shelter3 = create(:shelter)
      shelter4 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Tyrell", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user3 = User.create!(name: "Brian Zanti", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user1.reviews.create!({title: "Great Shelter!", rating: "5", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user1.reviews.create!({title: "Awful Shelter!", rating: "3", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review3 = user1.reviews.create!({title: "Blah Shelter!", rating: "4", content: "I had a horrible experience here!", shelter_id: shelter3.id})
      review4 = user1.reviews.create!({title: "Meh Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter4.id})
      review5 = user2.reviews.create!({title: "Blarg Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter4.id})

      visit "/shelters"

      within "#top-3" do
        expect(page).to have_link("#{shelter1.name} Rating: #{shelter1.average_review_rating}")
        expect(page).to have_link("#{shelter3.name} Rating: #{shelter3.average_review_rating}")
        expect(page).to have_link("#{shelter2.name} Rating: #{shelter2.average_review_rating}")
      end
    end
  end
end
