class Biz::GroupBaseController < ApplicationController
  layout 'biz/group'
  before_filter  :require_wx_mp_user,  :require_education_industry, :require_group, :set_seo

  private

  def require_group
    @group = current_user.group
    redirect_to groups_path, notice: "请先设置微团购" unless @group
  end

  def set_seo(titles = nil)
    @current_titles = titles || %w(微团购支付版)
  end

  def require_education_industry
    #redirect_to account_path, alert: '你没有权限,请选择行业版本' unless current_user.industry_group?
  end
end
