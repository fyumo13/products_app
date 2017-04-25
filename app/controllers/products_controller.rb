class ProductsController < ApplicationController
  # displays a list of products the user can purchase
  # also displays products already purchased and products the current user has put for sale
  def index
    @user = User.find(session[:user_id])
    @products = Product.where.not(user: @user)
    @my_listings = Product.where(user: @user)
  end

  # creates a new product to be sold
  def create
    @product = Product.new(product_params)
    if !@product.save
      flash[:errors] = @product.errors.full_messages
    end
    redirect_to "/products"
  end

  # displays a page containing info specific to a particular product
  def show
    @user = User.find(session[:user_id])
    @product = Product.find(params[:id])
    @comments = Comment.where(product: @product)
  end

  # displays a page that allows user to edit info on a product they have put up for sale
  def edit
    @product = Product.find(params[:id])
  end

  # updates info specific to a particular product
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    if @product.save
      redirect_to "/products/#{@product.id}"
    else
      flash[:errors] = @product.errors.full_messages
      redirect_to "/products/#{@product.id}/edit"
    end
  end

  # deletes a product the user has put up for sale
  def destroy
    @product = Product.find(params[:id])
    if current_user == @product.user
      @product.destroy
    end
    redirect_to "/products"
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :price).merge(user: current_user)
    end
end
