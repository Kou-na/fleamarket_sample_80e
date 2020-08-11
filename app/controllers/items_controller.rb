class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images)
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(set_item)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def set_item
    params.require(:item).permit(:name, :price, :explain, :size, :prefecture_id, :brand, :shipping_date_id, :item_status_id, :postage_id, :category_id, images_attributes: [:src])
  end

  def buy
  end
end
