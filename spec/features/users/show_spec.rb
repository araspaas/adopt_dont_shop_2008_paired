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
    it "I see the average rating of all of their reviews" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      shelter3 = create(:shelter)
      shelter4 = create(:shelter)
      user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review3 = user.reviews.create!({title: "Blah Shelter!", rating: "3", content: "I had a horrible experience here!", shelter_id: shelter3.id})
      review4 = user.reviews.create!({title: "Meh Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter4.id})

      visit("/users/#{user.id}")

      expect(page).to have_content("Average Review Rating: #{user.average_review_rating.to_f.round(1)}")
    end
    it "I see the users best and worst review" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      shelter3 = create(:shelter)
      shelter4 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Tyrell", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user3 = User.create!(name: "Brian Zanti", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user1.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user1.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review3 = user1.reviews.create!({title: "Blah Shelter!", rating: "3", content: "I had a horrible experience here!", shelter_id: shelter3.id})
      review4 = user1.reviews.create!({title: "Meh Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter4.id})
      review5 = user2.reviews.create!({title: "Blarg Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter4.id})

      visit("/users/#{user1.id}")

      within "#highlighted" do
        expect(page).to have_content("#{user1.best_review.title}")
        expect(page).to have_content("#{user1.best_review.rating}")
        expect(page).to have_content("#{user1.best_review.content}")
        expect(page).to have_content("#{user1.worst_review.title}")
        expect(page).to have_content("#{user1.worst_review.rating}")
        expect(page).to have_content("#{user1.worst_review.content}")
      end
      visit("/users/#{user2.id}")

      within "#highlighted" do
        expect(page).to_not have_content("Best Review: ")
        expect(page).to_not have_content("Worst Review: ")
      end
      visit("/users/#{user3.id}")

      within "#highlighted" do
        expect(page).to_not have_content("Best Review: ")
        expect(page).to_not have_content("Worst Review: ")
      end
    end
  end
end
