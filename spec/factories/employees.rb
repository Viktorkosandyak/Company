FactoryBot.define do
  factory :employee do
    name  { Faker::Name.name }
    active    { false }
    departament_id  {  FactoryBot.create(:departament).id }
  end
end
