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

    # Render the index view, which will display all items
    render :index
  end
end
