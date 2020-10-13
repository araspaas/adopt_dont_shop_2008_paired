require "rails_helper"

describe "As a visitor" do
  describe "When i visit a users show page" do
    it "I see all of a users info" do
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")

      visit "/users/#{user1.id}"

      expect(page).to have_content(user1.name)
      expect(page).to have_content(user1.address)
      expect(page).to have_content(user1.city)
      expect(page).to have_content(user1.state)
      expect(page).to have_content(user1.zip)

      visit "/users/#{user2.id}"

      expect(page).to have_content(user2.name)
      expect(page).to have_content(user2.address)
      expect(page).to have_content(user2.city)
      expect(page).to have_content(user2.state)
      expect(page).to have_content(user2.zip)
    end
    it "I can see every review that the user has written" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      visit("/users/#{user.id}")

      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating)
      expect(page).to have_content(review1.content)
      expect(page).to have_xpath("//img[@src='#{review1.image}']")
      expect(page).to have_content(review1.user.name)

      expect(page).to have_content(review2.title)
      expect(page).to have_content(review2.rating)
      expect(page).to have_content(review2.content)
      expect(page).to have_content(review2.user.name)
    end
  end
end
