class DepartamentsController < ApplicationController

  before_action :set_departament, only: [:show, :edit, :update, :destroy]

  def new
    @departament = Departament.new
  end

  def index
    @departaments = Departament.paginate(:page => params[:page], per_page:2)
  end

  def show
  end

  def edit
  end

  def create
    @departament = Departament.new(departament_params)
    if @departament.save
    redirect_to @departament
    else
      render 'new'
    end
  end

  def update
    if @departament.update(departament_params)
      redirect_to @departament
    else
      render 'edit'
    end
  end

  def destroy
    @departament.destroy
    redirect_to departaments_path
  end

  private

    def departament_params
      params.require(:departament).permit(:name)
    end

    def set_departament
      @departament = Departament.find(params[:id])
    end

end
