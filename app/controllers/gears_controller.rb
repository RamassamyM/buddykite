class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    byebug
  end

  def show

    @gear = Gear.find(params[:id])
    @size = Size.find(@gear.size_id)
    @category = Category.find(@size.category_id)

  end
end
