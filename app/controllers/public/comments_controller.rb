class Public::CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = Commenet.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.item_id = @item.id
    @comment.save
  end

  def destroy
    @item = Item.find(@params[:item_id])
    @item_comments = @item.comments
    Comment.find_by(id: params[:id], item_id: params[:item_id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :star)
  end
end
