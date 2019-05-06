class Employee < ApplicationRecord
  belongs_to :departament
  validates :name,  presence: true, length: { minimum: 4 }

  def self.search(query_value)
    if query_value.present?
      Employee.where(["lower(name) LIKE ?", "#{query_value.downcase}%"])
    else
      Employee.all
    end
  end
end
