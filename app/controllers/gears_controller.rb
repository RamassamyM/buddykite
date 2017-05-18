# top-level class documentation comment HERE
class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if search_params[:category_id].empty?
      redirect_back(fallback_location: root_path, alert: 'Please choose the gear category you are looking for')
    else
      @gears = Gear.select('gears.*')
                  .joins(:size)
                  .where('sizes.category_id = ?' ,search_params[:category_id])
                  .near(search_params[:city], 20)
      @category = Category.find(search_params[:category_id]).name
    end
  end

  def show
    @gear = Gear.find(params[:id])
    @user = User.find(@gear.user_id)
    # @gear = Gear.where.not(latitude: nil, longitude: nil)
    @hash = Gmaps4rails.build_markers(@gear) do |gear, marker|
      marker.lat gear.latitude
      marker.lng gear.longitude
    end
  end

  private
    def search_params
      params.require(:search).permit(:city, :start_date, :end_date, :category_id)
    end

end
