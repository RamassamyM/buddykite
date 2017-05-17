class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @gears = Size.where('category_id = ?', search_params[:category_id]).gears
    @search = search_params
  end

  def show

  @gear = Gear.find(params[:id])

  end

  private
    def search_params
      params.require(:search).permit(:city, :date, :category_id)
    end
end



# <ActionController::Parameters
# {"utf8"=>"✓",
# "search"=>{"city"=>"Bordeaux",
#   "date"=>"17/03/2018", "category_id"=>"1"},
# "commit"=>"Find", "controller"=>"gears", "action"=>"index"}
# permitted: false>


# def reversed_sorted_artists
#   Artist.all.order(name: :desc)
# end

# def love_tracks
#   Track.where('name LIKE ?', '%love%')
# end

# def long_tracks(min_length)
#   Track.where('milliseconds > ?', min_length * 60_000)
# end

# def top_five_artists(genre_name)
#   Artist.select('artists.*, COUNT(tracks.name) AS track_count')
#     .joins(albums: { tracks: :genre })
#     .where(genres: { name: genre_name })
#     .group('artists.name')
#     .order('track_count DESC')
#     .limit(5)
# end
