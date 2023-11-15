class Public::CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.item_id = @item.id
    @comment.save
    redirect_to item_path(@item.id)
  end

  # def destroy
  #   @item = Item.find(params[:item_id])
  #   Comment.find_by(id: params[:id], item_id: params[:item_id]).destroy
  #   @item_comments = @item.comments
  # end

  def destroy
    @item = Item.find(params[:id])
    Comment.find(params[:id]).destroy
    @item_comments = @item.comments
    redirect_to item_path(@item.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :star)
  end
end
