require 'rails_helper'

describe "As a visitor" do
  describe "when I visit a shelters show page I see a link to edit the shelter review next to each review" do
    it "when I click the edit link, I am taken to an edit shelter page with a pre-populated edit shelter form" do
      shelter = create(:shelter)
      user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review = user.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter.id})
      visit("/shelters/#{shelter.id}")
      click_link "Edit Review"

      expect(current_path).to eq("/shelters/#{shelter.id}/reviews/#{review.id}/edit")

      expect(page).to have_field('Title', with: review.title)
      expect(page).to have_field('Rating', with: review.rating)
      expect(page).to have_field('Content', with: review.content)
      expect(page).to have_field('Image', with: review.image)
      expect(page).to have_field('User', with: review.user.name)

      fill_in("Rating", with: "5")

      click_on "Update Review"

      expect(current_path).to eq("/shelters/#{shelter.id}")
      expect(page).to have_content(review.title)
      expect(page).to have_content("Rating: 5")
      expect(page).to have_content(review.content)
      expect(page).to have_xpath("//img[@src='#{review.image}']")
      expect(page).to have_content(review.user.name)
    end
    it "When I fail to enter required info I see a message asking me to do so" do
      shelter = create(:shelter)
      user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review = user.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter.id})
      visit("/shelters/#{shelter.id}")
      click_link "Edit Review"

      expect(current_path).to eq("/shelters/#{shelter.id}/reviews/#{review.id}/edit")

      expect(page).to have_field('Title', with: review.title)
      expect(page).to have_field('Rating', with: review.rating)
      expect(page).to have_field('Content', with: review.content)
      expect(page).to have_field('Image', with: review.image)
      expect(page).to have_field('User', with: review.user.name)

      fill_in("Rating", with: "")

      click_on "Update Review"

      expect(page).to have_content("Rating can't be blank")
    end
    it "when I submit the name of a user that doesn't exist, I get a flash message indicating that the user wasn't found and I am returned to the edit form" do
      shelter = create(:shelter)
      user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review = user.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter.id})
      visit("/shelters/#{shelter.id}")
      click_link "Edit Review"
      
      expect(current_path).to eq("/shelters/#{shelter.id}/reviews/#{review.id}/edit")

      expect(page).to have_field('Title', with: review.title)
      expect(page).to have_field('Rating', with: review.rating)
      expect(page).to have_field('Content', with: review.content)
      expect(page).to have_field('Image', with: review.image)
      expect(page).to have_field('User', with: review.user.name)

      fill_in("User", with: "Rene")

      click_on "Update Review"

      expect(page).to have_content("User Must Exist")
    end
  end
end
