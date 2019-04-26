class EmployeesController < ApplicationController

  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def new
    @employee = Employee.new
  end

  def index
    @employees = Employee.all
  end

  def show
  end

  def edit
  end

  def create
    @employee = Employee.find(params[:id])
    @employee = Employee.new(employee_params)
    binding.pry
    if @employee.save
    redirect_to @employee
    else
      render 'new'
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee
    else
      render 'edit'
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :active, :departament_id)
    end

    def set_employee
      @employee = Employee.find(params[:id])
    end

end
