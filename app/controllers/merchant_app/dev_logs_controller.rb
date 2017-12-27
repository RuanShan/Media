class MerchantApp::DevLogsController < Api::V1::BaseController
  layout 'merchant_app'
  before_action :require_account

end