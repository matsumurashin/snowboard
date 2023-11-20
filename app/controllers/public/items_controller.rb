class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.all.page(params[:page]).per(10)
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @items.where(genre_id: params[:genre_id])
    end
    @comments = Comment.all
    # @all_stars = '総合評価'
    # @star1 = '評価1'
    # @star2 = '評価2'
    # @star3 = '評価3'
    # @star4 = '評価4'
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
    @comment = Comment.new
    @item_comments = @item.comments.all
    @all_stars = '総合評価'
    @star1 = '評価1'
    @star2 = '評価2'
    @star3 = '評価3'
    @star4 = '評価4'
  end

  # def create
  #   @item = Item.find(params[:item_id])
  #   @comment = current_customer.comments.new(comment_params)
  #   @comment.item_id = @item.id
  #   @comment.save
  #   redirect_to item_path(@item.id)
  # end

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

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :size, :genre_id)
  end

end
