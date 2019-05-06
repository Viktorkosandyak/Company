module EmployeesHelper

  def departament_select
    Departament.all.pluck(:name, :id)
  end
end
