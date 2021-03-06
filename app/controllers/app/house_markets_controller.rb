module App
  class HouseMarketsController < BaseController
    layout "app/house_market"
    before_action :find_house, :require_wx_user

    def new
      @house_bespeak = HouseBespeak.new(user_id: session[:user_id])
    end

    def create
     params[:house_bespeak][:order_time] =  "#{params[:house_bespeak][:order_time]} #{params[:order_for_time]['(4i)']}:#{params[:order_for_time]['(5i)']}"
      @house_bespeak = @house.bespeaks.build(params[:house_bespeak])
      if @house_bespeak.save!
        redirect_to new_app_house_market_url, :notice => "报名成功"
      else
        flash[:notice] = "报名失败"
        render :action => :new
      end
    end

    private
    def find_house
      @activity = Activity.find(session[:activity_id])
      @house = House.find(@activity.site.house.id)
    rescue
      render :text => "参数错误"
    end

  end
end
