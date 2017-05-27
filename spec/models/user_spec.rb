require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:address).dependent(:destroy) }
    it { should have_many(:competencies).dependent(:destroy) }
    it { should have_many(:skills).through(:competencies) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_uniqueness_of(:cpf) }
    it { should validate_length_of(:cpf).is_equal_to(11) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should validate_uniqueness_of(:phone) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:birth_date) }
  end
end
