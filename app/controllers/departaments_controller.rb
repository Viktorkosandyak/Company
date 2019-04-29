class DepartamentsController < ApplicationController
  before_action :set_departament, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @departament = Departament.new
  end

  def index
    @departaments  = Departament.search(params[:search]).paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def edit
  end

  def create
    @departament = Departament.new(departament_params)
    if @departament.save
    redirect_to @departament, success: "Departament successfully create"
    else
      render 'new', danger: "Departament not updated"
    end
  end

  def update
    if @departament.update(departament_params)
      redirect_to @departament, success: "Departament successfully update"
    else
      render 'edit', danger: "Departament not updated"
    end
  end

  def destroy
    @departament.destroy
    redirect_to departaments_path, danger: "Departament successfully delete"
  end

  private

    def departament_params
      params.require(:departament).permit(:name)
    end

    def set_departament
      @departament = Departament.find(params[:id])
    end
end
