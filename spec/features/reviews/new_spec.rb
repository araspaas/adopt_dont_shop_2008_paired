require "rails_helper"

describe "as a visitor" do
  describe "when I visit a shelters show page" do
    describe "I see a link to add a review" do
      it "when I click this link im taken to a form" do
        shelter1 = create(:shelter)
        shelter2 = create(:shelter)
        user = User.create!(name: "John Doe", address: "123 candy cane lane", city: "Denver", state: "Colorado", zip: "80128")

        visit "/shelters/#{shelter1.id}"

        click_link "Add Review"

        expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/new")

        expect(page).to have_field('Title')
        expect(page).to have_field('Rating')
        expect(page).to have_field('Content')
        expect(page).to have_field('Name')
        expect(page).to have_field('Image')

        fill_in "Title", with: "This place rocks"
        fill_in "Rating", with: "5"
        fill_in "Content", with: "This place has everything you need"
        fill_in "Name", with: "#{user.name}"
        fill_in "Image", with: ""

        click_on "Add Review"

        expect(current_path).to eq("/shelters/#{shelter1.id}")

        expect(page).to have_content("This place rocks")
        expect(page).to have_content("5")
        expect(page).to have_content("This place has everything you need")
        expect(page).to have_content("#{user.name}")
      end
    end
  end
end
