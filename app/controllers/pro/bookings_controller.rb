class Pro::BookingsController < Pro::BookingBaseController
  skip_before_action :require_booking, only: [:index]

  before_action :load_booking, only: [:edit, :update, :destroy, :show]

  def index
    @bookings = current_site.bookings.page(params[:page])
  end

  def new
    @booking = current_site.create_booking
    redirect_to edit_booking_path(@booking)
  end

  def update
    if @booking.update_attributes(params[:booking])
      redirect_to :back, notice: '保存成功'
    else
      redirect_to :back, alert: "保存失败：#{@booking.errors.full_messages.join('，')}"
    end
  end

  def destroy
    # if @booking.clear_menus!
      redirect_to :back
    # else
    #   redirect_to :back, notice: '操作失败'
    # end
  end

  private

  def load_booking
    @booking = current_site.bookings.find(params[:id])
  end

end
