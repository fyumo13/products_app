class PurchasesController < ApplicationController
  # purchases a specific product
  def create
    Purchase.create(product_id: params[:product], user: current_user)
    redirect_to "/products"
  end

  # cancels the purchase of a specific product
  def destroy
    @purchase = Purchase.find(params[:id])
    if current_user == @purchase.user
      @purchase.destroy
    end
    redirect_to "/products"
  end
end
