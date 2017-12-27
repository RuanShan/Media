class Mobile::GroupCommentsController < Mobile::BaseController
  layout "mobile/group"

  before_action :set_item_and_comments, :except => [:create]

  def index
    @body_class = "shopcar comment"
  end

  def new
    @body_class = "comment"
    @comment = GroupComment.new(user_id: session[:user_id], group_order_id: params[:group_order_id])
  end

  def create
    @item = GroupItem.find(params[:id])
    @comment = @item.group_comments.new(params[:group_comment])
    if @comment.save
      redirect_to mobile_group_item_url(site_id: @site.id, id: @item.id, group_order_id: params[:group_comment][:group_order_id]), notice: '评论成功'
      #redirect_to new_mobile_group_comment_url(site_id: @site.id,:id => @item.id), :notice =>  "评论成功"
    else
      redirect_to mobile_group_item_url(site_id: @site.id, id: @item.id, group_order_id: params[:group_comment][:group_order_id]), alert: '评论失败'
      #render :action => :new, :notice => "评论失败"
    end
  end

  def set_item_and_comments
    @item = GroupItem.find(params[:id])
    @comments = @item.group_comments.order("created_at desc")
  end
end
