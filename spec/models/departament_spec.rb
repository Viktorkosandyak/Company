require 'rails_helper'

RSpec.describe Departament , type: :model do

  before do
    @departament =  build(:departament)
  end

  subject { @departament }

  context 'associations' do
    it { should have_many(:employees) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  it "is not valid without a name" do
    subject.name = ''
    expect(subject).to_not be_valid
  end
end
