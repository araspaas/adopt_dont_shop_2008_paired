require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:title) }
  end
  describe "relationships" do
    it { should belong_to(:shelter) }
    it { should belong_to(:user) }
  end
end
