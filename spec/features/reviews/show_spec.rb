require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelters show page" do
    it "I see a list of reviews for that shelter" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user.reviews.create({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user.reviews.create({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      visit("/shelters/#{shelter1.id}")
      
      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating)
      expect(page).to have_content(review1.content)
      expect(page).to have_xpath("//img[@src='#{review1.image}']")
      expect(page).to have_content(review1.user.name)

      visit("/shelters/#{shelter2.id}")
      expect(page).to have_content(review2.title)
      expect(page).to have_content(review2.rating)
      expect(page).to have_content(review2.content)
      expect(page).to have_content(review2.user.name)
    end
  end
end
