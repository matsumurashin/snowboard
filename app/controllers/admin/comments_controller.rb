class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :all_stars, :star1, :star2, :star3, :star4).merge(
      customer_id: current_customer.id, item_id: params[:item_id]
    )
  end
end
