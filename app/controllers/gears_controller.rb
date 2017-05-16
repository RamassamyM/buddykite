class GearsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    byebug
  end

  def show
  end
end
