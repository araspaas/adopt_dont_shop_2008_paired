require 'rails_helper'

describe "As a visitor" do
  describe "When I visit an admin applicaiton show page ('/admin/applications/:id')" do
    before :each do
      @shelter1 = Shelter.create(name: "Van's pet shop", address: "3724 tennessee dr", city: "Rockford", state: "Illinois", zip: "61108")
      @shelter2 = Shelter.create(name: "Bovice's pet shop", address: "1060 W Addison", city: "Chicago", state: "Illinois", zip: "61109")
      @pet1 = @shelter1.pets.create(image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg", name: "Bella", age: "5", sex: "female", description: "Fun Loving Dog", status: 0)
      @pet2 = @shelter2.pets.create(image: "https://static.insider.com/image/5d24d6b921a861093e71fef3.jpg", name: "Maisy", age: "6", sex: "female", description: "Stomache on legs", status: 0)
      @user = User.create!(name: "Tim Tyrell", address: "321 you hate to see it dr", city: "Denver", state: "Colorado", zip: "80000")
      @application = @user.applications.create(description: "I'm awesome, give me animals.", status: 1)
      @application.application_pets.create([{pet_id: @pet1.id}, {pet_id: @pet2.id}])
      visit "/admin/applications/#{@application.id}"
    end
    it "I see a button for every pet to approve that pet for the application" do
      within("#pet-application-status-#{@pet1.id}") do
        expect(page).to have_button("Approve Pet")
      end
      within("#pet-application-status-#{@pet2.id}") do
        expect(page).to have_button("Approve Pet")
      end
    end
    it "When I click that button, I'm taken back to the admin application show page and next to the pet I approved, I see an approval indicator next to the pet instead of an approaval button" do
      within("#pet-application-status-#{@pet1.id}") do
        click_button "Approve Pet"
        expect(page).to have_content("accepted")
        expect(page).to_not have_button("Approve Pet")
      end
      within("#pet-application-status-#{@pet2.id}") do
        click_button "Approve Pet"
        expect(page).to have_content("accepted")
        expect(page).to_not have_button("Approve Pet")
      end
    end
    it "I see a button for every pet to reject that pet for the application" do
      within("#pet-application-status-#{@pet1.id}") do
        expect(page).to have_button("Reject Pet")
      end
      within("#pet-application-status-#{@pet2.id}") do
        expect(page).to have_button("Reject Pet")
      end
    end
    it "When I click that button, I'm taken back to the admin application show page and next to the pet I rejected, I see an rejection indicator next to the pet instead of an reject button" do
      within("#pet-application-status-#{@pet1.id}") do
        click_button "Reject Pet"
        expect(page).to have_content("rejected")
        expect(page).to_not have_button("Reject Pet")
      end
      within("#pet-application-status-#{@pet2.id}") do
        click_button "Reject Pet"
        expect(page).to have_content("rejected")
        expect(page).to_not have_button("Reject Pet")
      end
    end
  end
end
