class OrdersController < ApplicationController

  def index
  end

  def create
    @gear = Gear.find(params[:gear_id])
    order_info = order_params
    order_info[:start_at] = Date.parse(order_params[:start_at])
    order_info[:end_at] = Date.parse(order_params[:end_at])
    @new_order = @gear.orders.new(order_info)
    if @new_order.save
      redirect_to orders_path
    else
      render "gears/show"
    end
  end

private

def order_params
  params.require(:order).permit(:start_at, :end_at)
end

end
