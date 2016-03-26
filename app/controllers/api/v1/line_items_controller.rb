class Api::V1::LineItemsController < ApplicationController
  before_action :load_line_item, except: [:create]

  def create
    line_item = LineItem.new(line_item_params)
    if line_item.save
      render json: line_item, status: 201, location: [:api, line_item]
    else
      render json: { errors: line_item.errors }, status: 422
    end
  end

  def show
    respond_with @line_item
  end

  def update
    if @line_item.update(line_item_params)
      render json: @line_item, status: 200, location: [:api, @line_item]
    else
      render json: { errors: @line_item.errors }, status: 422
    end
  end

  def destroy
    if @line_item.destroy
      head 204
    end
  end

  private

    def load_line_item
      @line_item = LineItem.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        head 422
    end

    def line_item_params
      params.require(:line_item).permit(:order_id, :product_id, :quantity)
    end
end
