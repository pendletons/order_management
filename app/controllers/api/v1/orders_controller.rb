class Api::V1::OrdersController < ApplicationController
  before_action :load_order, except: [:create]

  def create
    order = Order.new(order_params)
    if order.save
      render json: order, status: 201, location: [:api, order]
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  def show
    respond_with @order
  end

  def update
    if @order.update(order_params)
      render json: @order, status: 200, location: [:api, @order]
    else
      render json: { errors: @order.errors }, status: 422
    end
  end

  private

    def load_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:order_date)
    end
end
