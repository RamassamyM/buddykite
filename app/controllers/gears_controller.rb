# top-level class documentation comment HERE
class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if search_infos[:category_id].empty?
      redirect_back(fallback_location: root_path, alert: 'Please choose the gear category you are looking for')
    else
      if search_infos[:city].empty?
        @gears = Category.find(search_infos[:category_id])
                  .gears.where.not(latitude: nil, longitude: nil)
      else
        @gears = Category.find(search_infos[:category_id])
                  .gears.joins(:orders)
                  .where("((? - orders.end_at) * (orders.start_at - ?)) < 0",
                      Date.parse(search_infos[:start_date]), Date.parse(search_infos[:end_date]))
                  .near(search_infos[:city], 20)
      end
      @hash = Gmaps4rails.build_markers(@gears) do |gear, marker|
        marker.lat gear.latitude
        marker.lng gear.longitude
        # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
      end
      @category = Category.find(search_params[:category_id]).name
    end
  end

  def show
    @gear = Gear.find(params[:id])
    @user = User.find(@gear.user_id)
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
