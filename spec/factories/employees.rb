FactoryBot.define do
  factory :employee do
      first_name  { Faker::Name.first_name }
      active    { false }
      departament_id  { Faker::Name.departament_id }
  end
end
