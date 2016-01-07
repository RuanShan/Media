module App
  class ActivityGroupsController < BaseController
    layout 'app/activity_groups'
    before_filter :require_activity, only: [:index, :show, :new]
    before_filter :require_wx_user

    def index
      @consume_code = get_consume!(@activity) if @activity.deal_success?
    end

    def show
      @activity.complete_cupon

      if @activity.activity_groups.where(wx_user_id: session[:wx_user_id]).count > 0
        redirect_to app_activity_groups_path(id: @activity.id, wxmuid: @activity.wx_mp_user_id)
      end
    end

    def new
      return redirect_to app_activity_groups_path(id: @activity.id) if @activity.activity_groups.where(wx_user_id: session[:wx_user_id]).count>0
      @activity_group = @activity.activity_groups.new(wx_user_id: session[:wx_user_id], activity_id: session[:activity_id])
    end

    def create
      @activity = Activity.find(params[:activity_group][:activity_id])
      return redirect_to app_activity_groups_path(id: @activity.id) if @activity.activity_groups.where(wx_user_id: session[:wx_user_id]).count>0
      @activity_group = @activity.activity_groups.new(params[:activity_group])

      if @activity_group.save

        @activity.complete_cupon

        redirect_to app_activity_groups_path(id: @activity.id), notice: "报名成功"
      else
        render action: 'new', alert: '报名团购失败'
      end
    end

    private
    def get_consume! activity
      return '' if session[:wx_user_id].blank? or session[:wx_mp_user_id].blank?
      sn = ''
      group_user = activity.activity_groups.where("wx_user_id = ?", session[:wx_user_id]).first
      if group_user
        activity_consume = activity.activity_consumes.where(supplier_id: activity.supplier_id, wx_mp_user_id: session[:wx_mp_user_id], wx_user_id: session[:wx_user_id]).first_or_create(mobile: group_user.mobile, activity_group_id: group_user.id)
        sn = activity_consume.code if activity_consume
      end
      sn
    end

    def require_activity
      @activity = Activity.where(id: params[:id]).first

      if @activity.blank?
        return render text: '活动不存在'
      else
        session[:activity_id] = @activity.id
      end
    end

  end
end
