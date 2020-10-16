require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end
  describe "relationships" do
    it { should have_many :reviews }
  end
  describe "instance methods" do
    it ".average_review_rating" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      shelter3 = create(:shelter)
      shelter4 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user1.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user1.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review3 = user1.reviews.create!({title: "Blah Shelter!", rating: "3", content: "I had a horrible experience here!", shelter_id: shelter3.id})
      review4 = user1.reviews.create!({title: "Meh Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter4.id})

      expect(user1.average_review_rating).to eq(2.5)
      expect(user2.average_review_rating).to eq(0)
    end
    it ".best_review" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      shelter3 = create(:shelter)
      shelter4 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user1.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user1.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review3 = user1.reviews.create!({title: "Blah Shelter!", rating: "3", content: "I had a horrible experience here!", shelter_id: shelter3.id})
      review4 = user1.reviews.create!({title: "Meh Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter4.id})

      expect(user1.best_review).to eq(review1)
      expect(user2.best_review).to eq(nil)
    end
    it "text" do
      shelter1 = create(:shelter)
      shelter2 = create(:shelter)
      shelter3 = create(:shelter)
      shelter4 = create(:shelter)
      user1 = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      user2 = User.create!(name: "Tim Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")
      review1 = user1.reviews.create!({title: "Great Shelter!", rating: "4", content: "I had a great experience here!", image: "https://cdn.pixabay.com/photo/2017/11/15/13/52/bulldog-2952049_960_720.jpg", shelter_id: shelter1.id})
      review2 = user1.reviews.create!({title: "Awful Shelter!", rating: "2", content: "I had a horrible experience here!", shelter_id: shelter2.id})
      review3 = user1.reviews.create!({title: "Blah Shelter!", rating: "3", content: "I had a horrible experience here!", shelter_id: shelter3.id})
      review4 = user1.reviews.create!({title: "Meh Shelter!", rating: "1", content: "I had a horrible experience here!", shelter_id: shelter4.id})

      expect(user1.worst_review).to eq(review4)
      expect(user2.worst_review).to eq(nil)
    end
  end
end
