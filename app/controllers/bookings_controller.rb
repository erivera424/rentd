class BookingsController < ApplicationController
  def index
    @requests = current_user.bookings # owner
    @bookings = Booking.where(user: current_user) # customer
  end

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
      redirect_to bookings_path, notice: "Congrats"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def approve
    booking = Booking.find(params[:booking_id])
    booking.update(status: "approved")
    redirect_to bookings_path, notice: "You are approved"
  end

  def decline
    booking = Booking.find(params[:booking_id])
    booking.update(status: "declined")
    redirect_to bookings_path, notice: "You are denied"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
