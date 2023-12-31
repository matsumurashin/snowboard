class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
    @item = Item.find(params[:item_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.item_id = @item.id
    @comment.save!
    redirect_to item_path(@item.id)
  end

  def destroy
    @item = Item.find(params[:item_id])
    Comment.find(params[:id]).destroy
    @item_comments = @item.comments
    redirect_to item_path(@item.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :all_stars, :star1, :star2, :star3, :star4).merge(
      customer_id: current_customer.id, item_id: params[:item_id]
    )
  end
end
