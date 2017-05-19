class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_searched_in_session, only: :home

  def home
  end
end
