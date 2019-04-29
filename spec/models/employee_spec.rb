require 'rails_helper'

RSpec.describe Employee, type: :model do
  context 'associations' do
    it { should belong_to(:departament) }
  end

  context 'validations name' do
    it { should validate_length_of(:name).is_at_least(4) }
    it { should validate_presence_of(:name) }
  end

  it "is not valid without a departament_id" do
    subject.departament_id = ''
    expect(subject).to_not be_valid
  end
  
end
