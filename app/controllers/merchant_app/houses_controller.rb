class MerchantApp::HousesController < Api::V1::BaseController
  layout 'merchant_app'
  before_filter :require_supplier

  def index; end
  def show; end

end
