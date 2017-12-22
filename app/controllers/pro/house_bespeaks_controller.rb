class Pro::HouseBespeaksController < Pro::HousesBaseController

  def index
    @search   = current_site.house.bespeaks.order('id DESC').search(params[:search])
    @bespeaks = @search.result.page(params[:page])
    @activity = current_site.create_activity_for_house_bespeak
  end

  def activity
    @activity = current_site.create_activity_for_house_bespeak
  end

  def update_activity
    @activity = current_site.create_activity_for_house_bespeak
    if @activity.update_attributes(params[:activity])
      #redirect_to activity_house_bespeaks_path, notice: '保存成功'
      redirect_to house_bespeaks_path, notice: '保存成功'
    else
      flash[:alert] = '保存失败'
      #render :activity
      redirect_to house_bespeaks_path
    end
  end

end
