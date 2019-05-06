class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def new
    @employee = Employee.new
  end

  def index
    @employees  = Employee.search(params[:search]).includes(:departament).paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
    redirect_to @employee, success: "Employee successfully create"
    else
      render 'new', danger: "Employee not updated"
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee, success: "Employee successfully update"
    else
      render 'edit', danger: "Employee not updated"
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path, danger: "Employee successfully delete"
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :active, :departament_id)
    end

    def set_employee
      @employee = Employee.find(params[:id])
    end
end
