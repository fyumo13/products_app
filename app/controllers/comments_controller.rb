class CommentsController < ApplicationController
  # submits a comment about a particular product
  def create
    @user = User.find(session[:user_id])
    @product = Product.find(params[:id])
    @comment = Comment.new(content: params[:content], user: @user, product: @product)
    if !@comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to "/products/#{@product.id}"
  end
end
