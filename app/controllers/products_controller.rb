class ProductsController < ApplicationController
  before_action :require_login
  before_action :set_product, only: %i[ show edit update destroy]
  before_action :error_occurred, only: [ :create ]
  def index
    @products = Product.all
  end

  def show
    @message = "This is the show action"
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product was successfully deleted."
  end

  def require_login
    @login_message = "You must be logged in to access this section"
  end

  def error_occurred
    @error_message = "There was a problem creating the product"
  end



  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.expect(product: [ :name ])
  end
end
