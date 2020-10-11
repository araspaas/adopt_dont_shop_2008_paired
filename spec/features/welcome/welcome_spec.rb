require "rails_helper"

describe "As a visitor" do
  describe "When I visit Adopt dont Shop website" do
    it "I see the wabpages name and links to shelter index and pets index" do

      visit "/"

      expect(page).to have_link("Shelters Index")
      expect(page).to have_link("Pets Index")
      expect(page).to have_content("Welcome To Adopt Dont Shop!")
    end
  end
end
