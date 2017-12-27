class MerchantApp::HousesController < Api::V1::BaseController
  layout 'merchant_app'
  before_action :require_account

end
