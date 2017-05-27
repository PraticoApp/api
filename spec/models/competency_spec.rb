require 'rails_helper'

RSpec.describe Competency, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:skill) }
  end

  describe 'validations' do
    before(:each) { create(:competency) }

    it { should validate_presence_of(:user) }
    it { should validate_uniqueness_of(:user).scoped_to(:skill_id) }
    it { should validate_presence_of(:skill) }
    it { should validate_uniqueness_of(:skill).scoped_to(:user_id) }
  end
end
