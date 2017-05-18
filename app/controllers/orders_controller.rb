class OrdersController < ApplicationController

  def index
    @user_orders = current_user.orders
    @owner_orders = current_user.own_orders
  end

  def new
  end

  def create

  end

end
