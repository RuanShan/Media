class Mobile::BrokeragesController < Mobile::BaseController
  before_action :require_wx_user, :get_share_image, :require_brokerage_setting
  before_action :require_broker, only: [ :broker, :edit, :update, :my_clients, :put_clients, :save_client, :commission_list, :client_change_list ]
  layout 'mobile/brokerages'

  def index;end

  def broker
  	redirect_to new_mobile_brokerage_url(@site), notice: "请先注册！" unless @broker 
  end

  def new
  	@broker = @site.brokerage_brokers.new
  end

  def edit;end

  def create
    return render js: 'alert("该手机号已被使用!");$("#broker").prop("disabled", false);' if @site.brokerage_brokers.where(mobile: params[:brokerage_broker][:mobile]).exists?
    return render js: 'alert("验证码不正确！");$("#broker").prop("disabled", false);' if params[:captcha].blank? || params[:captcha].to_i != session[:captcha].to_i
    @broker = @site.brokerage_brokers.new(params[:brokerage_broker])
    if @broker.save
      render js: "alert('注册成功');location.href='#{broker_mobile_brokerages_url}';"
    else
      render js: "alert('注册失败：#{@broker.errors.full_messages.join('\n')}');$('#broker').prop('disabled', false);"
    end
  end

  def update
    if @broker.update_attributes(params[:brokerage_broker])
      render js: "alert('保存成功');"
    else
      render js: "alert('保存失败：#{@broker.errors.full_messages.join('\n')}');"
    end
  end

  def send_sms
    return render js: 'alert("该手机号已被使用!");' if @site.brokerage_brokers.where(mobile: params[:mobile]).exists?
    session[:captcha], session[:mobile] = rand(100000..999999).to_s, params[:mobile].to_s
    SmsAlidayu.new.send_code_for_verify(session[:mobile], session[:captcha])
    render js: 'void(0);'
  end

  def my_clients
    @my_clients = @broker.clients.client_type_count(params[:mission_type]).order("id DESC").page(params[:page])
  end

  def put_clients
    @client = @broker.clients.new
  end

  def save_client
    @client = @broker.clients.new(params[:brokerage_client])
    if @client.save
      redirect_to broker_mobile_brokerages_url, notice: "推荐成功"
    else
      render_with_alert :put_clients, "推荐失败,#{@client.errors.full_messages.join(',')}"
    end
  end

  #结算明细
  def commission_list
    @setting = @site.brokerage_setting
    @commission_list = @broker.commission_transactions.order("id DESC").page(params[:page])
  end

  #账目明细
  def client_change_list
    @commission_transaction = @broker.commission_transactions.find(params[:id])
    @client_changes = @commission_transaction.client_changes.order("id DESC").page(params[:page])
  end

  private
  	def require_brokerage_setting
  		@brokerage = @site.brokerage_setting
  		return render_404 unless @brokerage
  	end

    def get_share_image
      @activity = @site.brokerage_activity
      @share_image = @activity.qiniu_pic_url || @activity.default_pic_url
    rescue => e
      @share_image = qiniu_image_url(Concerns::ActivityQiniuPicKeys::KEY_MAPS[77])
    end

    def require_broker
      @broker = @user.try(:broker)
      return render_404 unless @broker
    end
end