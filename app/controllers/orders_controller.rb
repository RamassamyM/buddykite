class OrdersController < ApplicationController

  def index
    @user_orders = current_user.orders
    @owner_orders = current_user.own_orders
  end

  def create
    @gear = Gear.find(params[:gear_id])
    order_info = {}
    order_info[:start_at] = Date.parse(order_params[:start_at])
    order_info[:end_at] = Date.parse(order_params[:end_at])
    order_info[:user] = current_user
    order_info[:infos] = @gear.price
    @new_order = @gear.orders.new(order_info)
    if @new_order.save
      redirect_to orders_path
    else
      render "gears/show"
    end
  end

  def update
    order = Order.find(params[:id])
    if order.update(review_params)
      redirect_to orders_path
    else
      render 'orders/index'
    end
  end

private

def order_params
  params.require(:order).permit(:start_at, :end_at)
end

def review_params
  params.require(:order).permit(:reviews, :rating)
end

end
