class BookingsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @booking = Booking.new
  end

  def create
    @item = Item.find(params[:item_id])
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @booking.status = "pending"
    days = (@booking.end_date - @booking.start_date).to_i
    @booking.total_price = days * @item.price
    @booking.item_id = @item.id

    if @booking.save
      redirect_to items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
