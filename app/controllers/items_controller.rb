class ItemsController < ApplicationController
  def index
    @items = Item.all

    # Additional logic for filtering
    if params[:category].present?
      @items = @items.where(category: params[:category])
    end

    # Additional logic for sorting
    if params[:sort] == 'price_asc'
      @items = @items.order(price: :asc)
    elsif params[:sort] == 'price_desc'
      @items = @items.order(price: :desc)
    end

    # Categorize items for the view
    @dresses = @items.where(category: 'dresses')
    @tops = @items.where(category: 'tops')
    @bottoms = @items.where(category: 'bottoms')
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to item_path(@item), notice: "Item was successfully created."
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :brand, :fabric_details, :original_price, :size)
  end
end
