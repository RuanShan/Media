module WeixinPay
  GATEWAY_URL = 'https://api.mch.weixin.qq.com'.freeze
  SANDBOX_GATEWAY_URL = 'https://api.mch.weixin.qq.com/sandboxnew'.freeze
  RESULT_SUCCESS = 'SUCCESS'.freeze
  INVOKE_UNIFIEDORDER_REQUIRED_FIELDS = [:appid, :mch_id, :key, :body, :out_trade_no, :total_fee, :spbill_create_ip, :notify_url, :trade_type]

    def invoke_unifiedorder(params, options = {})
      params = {
        nonce_str: SecureRandom.uuid.tr('-', '')
      }.merge(params)

      check_required_options(params, INVOKE_UNIFIEDORDER_REQUIRED_FIELDS)
Rails.logger.debug " invoke_unifiedorder=#{ params.inspect}"
      r = invoke_remote("/pay/unifiedorder", make_payload(params), options)

      yield r if block_given?

      r
    end

    def generate_noce_str
      str = "site0123456789"
      (0...32).map { str[rand(str.length)] }.join
    end

    def get_sign sign_params = [], key=''
      Digest::MD5.hexdigest(sign_params.sort.join('&') +  "&key=#{key}").upcase
    end

    def create_xml request_options = {}, sign = ''
      "<xml>
          <appid>#{request_options[:appid]}</appid>
          <mch_id>#{request_options[:mch_id]}</mch_id>
          <nonce_str>#{request_options[:nonce_str]}</nonce_str>
          <sign><![CDATA[#{sign}]]></sign>
          <body><![CDATA[#{request_options[:body]}]]></body>
          <out_trade_no>#{request_options[:out_trade_no]}</out_trade_no>
          <total_fee>#{request_options[:total_fee]}</total_fee>
          <spbill_create_ip>#{request_options[:spbill_create_ip]}</spbill_create_ip>
          <notify_url>#{request_options[:notify_url]}</notify_url>
          <trade_type>#{request_options[:trade_type]}</trade_type>
          <openid>#{request_options[:openid]}</openid>
       </xml>"
    end

    def get_sign_type
      "MD5"
    end

    def get_time_stamp
      Time.now.to_i.to_s
    end

    def set_sign_params request_options = {}
      ["appid=#{request_options[:appid]}", "mch_id=#{request_options[:mch_id]}", "nonce_str=#{request_options[:nonce_str]}", "body=#{request_options[:body]}", "out_trade_no=#{request_options[:out_trade_no]}", "total_fee=#{request_options[:total_fee]}","spbill_create_ip=#{request_options[:spbill_create_ip]}", "notify_url=#{request_options[:notify_url]}", "trade_type=#{request_options[:trade_type]}", "openid=#{request_options[:openid]}"]
    end

    def write_weixinv2_log result = ""
      SiteLog::Base.logger('wxpay', result)
    end

    def write_wxredpacket_log(info = '')
      SiteLog::Base.logger('wxredpacketpay', info)
    end

    def notify_result result = ''
      "<xml>
        <return_code><![CDATA[#{result}]]></return_code>
        <return_msg><![CDATA[#{result}]]></return_msg>
      </xml>"
    end

    def sandbox_mode?
      PAYMENT_CONFIG['wxpay']['sandbox']
    end

    def get_sandbox_signkey(mch_id, key)
      params = {
        key: key,
        mch_id: mch_id,
        nonce_str: SecureRandom.uuid.tr('-', '')
      }
      r = invoke_remote("/pay/getsignkey", xmlify_payload(params))
      yield r if block_given?
      r
    end

    private
    def get_gateway_url
      return SANDBOX_GATEWAY_URL if sandbox_mode?
      GATEWAY_URL
    end

    def make_payload(params)
      if sandbox_mode?
        mch_id = params[:mch_id]
        key = params[:key]
        xml = get_sandbox_signkey(mch_id, key)
        r = HashWithIndifferentAccess.new(Hash.from_xml xml)[:xml]
        if r['return_code'] == RESULT_SUCCESS
          params = params.merge({
            :key => r['sandbox_signkey']
          })
        else
          warn("WxPay Warn: fetch sandbox sign key failed #{r['return_msg']} #{r.inspect}")
        end
      end
      xmlify_payload(params)
    end

    def xmlify_payload(params)
      sign = sign_params(params)
      params.delete(:key) if params[:key]
Rails.logger.debug " sign_params = #{params.inspect}, sign = #{sign}"
      "<xml>#{params.map { |k, v| "<#{k}>#{v}</#{k}>" }.join}<sign>#{sign}</sign></xml>"
    end

    def sign_params( params )
      key = params.delete(:key)
      Rails.logger.debug " sign_params = #{params.inspect}, key = #{key}"

      query = params.sort.map do |k, v|
        "#{k}=#{v}" if v.to_s != ''
      end.compact.join('&')

      Digest::MD5.hexdigest("#{query}&key=#{key}").upcase
    end


    def check_required_options(options, names)
      names.each do |name|
        warn("WxPay Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end

    # for notify
    def request_content
      params[:xml].nil? ? Hash.from_xml(request.raw_post) : { 'xml' => params[:xml] }
    end

    def invoke_remote(url, payload, options = {})
      url = "#{get_gateway_url}#{url}"
      response = HTTParty.post(url, body:payload, headers:{'ContentType' => 'application/xml'} )
      Rails.logger.debug( "url=#{url},  response=#{response.inspect}")
      response.body
    end
end
