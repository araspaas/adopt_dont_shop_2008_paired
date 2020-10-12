require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/users/new'" do
    it "I see a form to create a user" do
      visit("/users/new")
      expect(page).to have_field('Name')
      expect(page).to have_field('Address')
      expect(page).to have_field('City')
      expect(page).to have_field('State')
      expect(page).to have_field('Zip')
      fill_in 'Name', with: "Scuba Steve"
      fill_in 'Address', with: "123 Boring Street"
      fill_in 'City', with: "New York"
      fill_in 'State', with: "New York"
      fill_in 'Zip', with: "12345"
      click_on("Create User")
      user = User.all.last
      expect(current_path).to eq("/users/#{user.id}")
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
    end
  end
end
