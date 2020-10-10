require "rails_helper"

describe "as a visitor" do
  describe "when i visit a pets show page" do
    it "I can delete a pet" do
      shelter_1 = create(:shelter)

      pet1 = shelter_1.pets.create!(name: "Bella", image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", age: "5", sex: "Female", description: "Bork", status: 0)

      visit "/pets/#{pet1.id}"

      expect(page).to have_link("Delete Pet")

      click_link("Delete Pet")

      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(pet1.name)
    end
  end
end
