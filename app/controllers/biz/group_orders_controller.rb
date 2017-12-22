class Biz::GroupOrdersController < Biz::GroupBaseController
  before_filter :set_group
  before_filter :set_group_order, only: [:show, :consume, :destroy]

  def index
    @search    = current_site.group_orders.latest.search(params[:search])
    @group_orders = @search.result.include(:payments).page(params[:page])
  end

  def show
    render layout: 'application_pop'
  end

  def consume
    if @group_order.consume!
      redirect_to :back, notice: '消费成功'
    else
      redirect_to :back, notice: '消费失败'
    end
  end

  def destroy
    if @group_order.delete!
      redirect_to :back, notice: '取消成功'
    else
      redirect_to :back, notice: '取消失败'
    end
  end

  private

  def set_group_order
    @group_order = current_site.group_orders.find(params[:id])
    @group_item  = @group_order.group_item
  end

  def set_group
    @group = current_site.group
    @activity =  @group.activity
  end
end
