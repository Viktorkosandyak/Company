#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  Departament.create!(name: Faker::Job.position)
end

50.times do
  Employee.create!(name: Faker::Name.name, active: true , departament_id: Departament.all.ids.sample)
end
