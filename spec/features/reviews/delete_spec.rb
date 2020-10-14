require "rails_helper"

describe "As a visitor" do
  describe "when I visit a shelter's show page" do
    it "I can se a link to delete a review and use it" do
      shelter = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim", address: "123 cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user1.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter.id})
      review2 = user2.reviews.create!({title: "Bad Shelter!", rating: "1", content: "I had Horrible great experience here!", shelter_id: shelter.id})
      visit("/shelters/#{shelter.id}")

      within "#review-#{review1.id}" do
        click_link "Delete Review"
      end

      expect(current_path).to eq("/shelters/#{shelter.id}")
      expect(page).to_not have_content(review1.title)

      visit("/shelters/#{shelter.id}")

      within "#review-#{review2.id}" do
        click_link "Delete Review"
      end

      expect(current_path).to eq("/shelters/#{shelter.id}")
      expect(page).to_not have_content(review2.title)
    end
  end
end
