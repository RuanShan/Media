class RepliesController < ApplicationController
  before_action :require_wx_mp_user

  before_action do
    @partialLeftNav = "/layouts/partialLeftWeixin"
  end

  def index
    @reply = @wx_mp_user.first_follow_reply || @wx_mp_user.replies.new(event_type: Reply::CLICK_EVENT)
  end

  def autoreply
    @reply = @wx_mp_user.autoreply || @wx_mp_user.replies.new(event_type: Reply::TEXT_EVENT)
  end

  def create
    @reply = @wx_mp_user.replies.new(reply_params.merge(site_id: @wx_mp_user.site_id))
    if @reply.save
      redirect_to :back, notice: '保存成功'
    else
      redirect_to :back, alert: "保存失败:#{@reply.errors.full_messages}"
    end
  rescue => error
    redirect_to :back, alert: "保存失败:#{error}"
  end

  def update
    @reply = @wx_mp_user.replies.find(params[:id])
    if @reply.update_attributes(reply_params)
      redirect_to :back, notice: '保存成功'
    else
      redirect_to :back, alert: '保存失败'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(permitted_reply_attributes)
  end
end
