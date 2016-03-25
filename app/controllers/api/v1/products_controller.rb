class Api::V1::ProductsController < ApplicationController
  def create
  end

  def show
    respond_with Product.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
