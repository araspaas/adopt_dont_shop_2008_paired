require "rails_helper"

describe "As a visitor" do
  describe "when I visit a pet show page" do
    it "I can update that pets info" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)

      visit "/pets/#{pet1.id}"

      expect(page).to have_link("Update Pet")

      click_link("Update Pet")

      expect(current_path).to eq("/pets/#{pet1.id}/edit")

      fill_in 'name',  with:     "Mrs Bigglesworth"

      click_on "Update Pet"

      expect(current_path).to eq("/pets/#{pet1.id}")
      expect(page).to have_content("Mrs Bigglesworth")
      expect(page).to have_content(pet1.age)
      expect(page).to have_content(pet1.sex)
      expect(page).to have_content(pet1.status)
      expect(page).to have_content(pet1.description)
    end
  end
end
