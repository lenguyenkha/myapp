class CommentsController < ApplicationController
  before_action :logged_in_user, :find_product, only: %i(create)
  before_action :find_comment, only: :destroy

  def new; end

  def create
    @comment = current_user.comments.build comment_params
    flash[:danger] = t ".comment_faild" unless @product.comments << @comment
    # redirect_to @product
    # ajax here
    @comments = @product.comments.desc_created_at.paginate page: params[:page],
      per_page: Settings.products.number_of_comment
    respond_to do |format|
      format.html{redirect_to @product}
      format.js
    end
  end

  def destroy
    flash[:danger] = t ".delete_failed" unless @comment.destroy
    @product = @comment.product
    # redirect_to @product
    # ajax here
    @comments = @product.comments.desc_created_at.paginate page: params[:page],
      per_page: Settings.products.number_of_comment
    respond_to do |format|
      format.html{redirect_to @product}
      format.js
    end
  end

  private

  def find_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.not_found_product"
    redirect_to root_path
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "comment.not_found_comments"
    redirect_to @product
  end

  def comment_params
    params.require(:comment).permit :content, :product_id
  end
end
