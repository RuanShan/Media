class Sms::ExpensesController < ApplicationController
  before_action do
    @partialLeftNav = "/layouts/partialLeftSys"
  end

  def index
    @operation_options = SmsExpense::operation_id_options
    @search = current_site.sms_expenses.succeed.search(params[:search])

    if params[:search] && @search.result.date_gteq && @search.result.date_lteq && @search.result.date_gteq > @search.result.date_lteq
      return redirect_to :back, alert: '开始时间不能大于结束时间'
    end

    @dates = @search.result.select("date").group("date").order("date desc").page(params[:page])
  end

end
