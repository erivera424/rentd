class ItemsController < ApplicationController

  def index
  end
  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @list.save
    if @item.save
      redirect_to item_path(@item), notice: "Item was successfully created."
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :brand, :fabric_details, :original_price, :size )
  end
end
