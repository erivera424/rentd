class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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
    @item.user_id = current_user.id
    if @item.save
      redirect_to item_path(@item), notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def upload_image
    result = Cloudinary::Uploader.upload("https://upload.wikimedia.org/wikipedia/commons/a/ae/Olympic_flag.jpg", public_id: "olympic_flag")
      # Process the result or handle any error conditions here
      # ...
  end


  private

  def item_params
    params.require(:item).permit(:title, :description, :category, :price, :brand, :fabric_details, :original_price, :size, photos: [])
  end
end
