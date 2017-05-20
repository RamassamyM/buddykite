# top-level class documentation comment HERE
class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_searched_in_session, only: [:index, :show]

  def index
    @search_infos = search_params
    if @search_infos[:category_id].empty?
      redirect_back(fallback_location: root_path, alert: 'To find a gear, please select a gear category')
    else
      category = Category.find(@search_infos[:category_id])
      store_search_infos_in_session(@search_infos)
      @gears = gears_search(category, @search_infos)
      @hash = build_map_markers(@gears)
      @category_name = category.name
    end
  end

  def show
    @gear = Gear.find(params[:id])
    @order = Order.new
  end

  private
    def search_params
      params.require(:search).permit(:location, :start_date, :end_date, :category_id)
    end

    def build_map_markers(gears)
      Gmaps4rails.build_markers(gears) do |gear, marker|
        marker.lat gear.latitude
        marker.lng gear.longitude
        # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
      end
    end

    def store_search_infos_in_session(search_infos)
      session[:searched] = { location: search_infos[:location],
                start_date: search_infos[:start_date],
                end_date: search_infos[:end_date],
                category_id: search_infos[:category_id]
      }
    end

    def gears_search(category, search_infos)
      if search_infos[:location].nil? || @search_infos[:location].empty?
        category.gears.where.not(latitude: nil, longitude: nil)
      elsif is_dates_missing(search_infos)
        category.gears.where.not(latitude: nil, longitude: nil)
                  .near(search_infos[:location], 20)
      else
        start_date = Date.parse(search_infos[:start_date])
        end_date = Date.parse(search_infos[:end_date])
        category.gears.joins(:orders)
                .where("((? - orders.end_at) * (orders.start_at - ?)) < 0", start_date, end_date)
                .near(search_infos[:location], 20)
      end
    end

    def is_dates_missing(search_infos)
      search_infos[:start_date].nil? || search_infos[:end_date].nil? || search_infos[:start_date].empty? || search_infos[:end_date].empty?
    end
end
