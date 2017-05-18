# top-level class documentation comment HERE
class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @search_infos = search_params
    session[:searched] = { city: @search_infos[:city],
                          start_date: @search_infos[:start_date],
                          end_date: @search_infos[:end_date],
                          category_id: @search_infos[:category_id]
                        }
    category = Category.find(@search_infos[:category_id])
    start_date = Date.parse(@search_infos[:start_date])
    end_date = Date.parse(@search_infos[:end_date])
    if @search_infos[:category_id].empty?
      redirect_back(fallback_location: root_path, alert: 'Please choose the gear category you are looking for')
    else
      if @search_infos[:city].empty?
        @gears = category.gears.where.not(latitude: nil, longitude: nil)
      else
        @gears = category.gears.joins(:orders)
                  .where("((? - orders.end_at) * (orders.start_at - ?)) < 0", start_date, end_date)
                  .near(@search_infos[:city], 20)
      end
      @hash = Gmaps4rails.build_markers(@gears) do |gear, marker|
        marker.lat gear.latitude
        marker.lng gear.longitude
        # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
      end
      @category_name = category.name
    end
  end

  def show
    @gear = Gear.find(params[:id])
    @user = @gear.owner
    @hash = Gmaps4rails.build_markers(@gear) do |gear, marker|
      marker.lat gear.latitude
      marker.lng gear.longitude
    end
    @order = Order.new
  end

  private
    def search_params
      params.require(:search).permit(:city, :start_date, :end_date, :category_id)
    end
end
