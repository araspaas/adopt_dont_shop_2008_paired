require "rails_helper"

describe "As a visitor" do
  describe "when I visit the pets index page" do
    describe "I see a link to start an application and when I click this link" do
      it "I can fill out a form for adopting pets" do
        shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")

        user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")

        visit "/pets"

        click_link "Start an Application"

        expect(current_path).to eq("/applications/new")

        expect(page).to have_field("user_name")

        fill_in "user_name", with: user.name

        click_button "Submit"
        application = Application.all.last
        expect(current_path).to eq("/applications/#{application.id}")

        expect(page).to have_content(application.user_name)
        expect(page).to have_content(application.full_address)
        expect(page).to have_content("in_progress")
      end
      it "Tells me if a user doesn't exist" do
        shelter = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")

        user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")

        visit "/pets"

        click_link "Start an Application"

        expect(current_path).to eq("/applications/new")

        expect(page).to have_field("user_name")

        fill_in "user_name", with: ""

        click_button "Submit"

        expect(page).to have_content("User Must Exist")
      end
    end
  end
end
