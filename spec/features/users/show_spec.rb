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
  end
end
