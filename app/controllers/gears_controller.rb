class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @gears = Gear.select('gears.*')
                .joins(:size)
                .where('sizes.category_id = ?' ,search_params[:category_id])
    @category = Category.find(search_params[:category_id]).name
  end

  def show

  @gear = Gear.find(params[:id])

  end

  private
    def search_params
      params.require(:search).permit(:city, :date, :category_id)
    end
end
