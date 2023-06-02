class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @items = Item.all

    # Search results
    if params[:query].present?
      @items = Item.search_by_five_columns(params[:query])
    else
      @items = Item.all
    end

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

    # Determine the filtered category
    @filtered_category = params[:category]

    # Filtered category headers
    @dresses_header = 'Dresses'
    @tops_header = 'Tops'
    @bottoms_header = 'Bottoms'
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to item_path(@item), notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category, :price, :brand, :fabric_details, :original_price, :size, photos: [])
  end
end
