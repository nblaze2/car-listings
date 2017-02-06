class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to cars_path, notice: 'Car was successfully created.'
    else
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:manufacturer_id, :model, :color, :year, :mileage, :description)
  end
end
