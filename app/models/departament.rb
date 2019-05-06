class Departament < ApplicationRecord
  has_many :employees, :dependent => :destroy
  validates_presence_of :name

  def self.search(query_value)
    if query_value.present?
      Departament.where(["lower(name) LIKE ?", "#{query_value.downcase}%"])
    else
      Departament.all
    end
  end

end
