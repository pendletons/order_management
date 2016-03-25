class Api::V1::ProductsController < ApplicationController
  before_action :load_product, except: [:create]

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: 201, location: [:api, product]
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def show
    respond_with @product
  end

  def update
    if @product.update(product_params)
      render json: @product, status: 200, location: [:api, @product]
    else
      render json: { errors: @product.errors }, status: 422
    end
  end

  def destroy
    if @product.destroy
      head 204
    else
      render json: { errors: @product.errors }, status: 422
    end
  end

  private

    def load_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price)
    end
end
