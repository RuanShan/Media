class Huodong::Brokerage::SettingsController < ApplicationController

    def index
        @brokerage = current_site.brokerage_setting
        @brokerage ||= ::Brokerage::Setting.new(activity: Activity.new(activity_type_id: 77))
    end

    def create
      @brokerage = ::Brokerage::Setting.new(brokerage_setting_params)
      if @brokerage.save
        redirect_to brokerage_settings_path, notice: "保存成功"
      else
          render_with_alert :index, "保存失败，#{@brokerage.errors.full_messages.first}"
      end
    end

    def update
        @brokerage = current_site.brokerage_setting
        if @brokerage.update_attributes(brokerage_setting_params)
            redirect_to brokerage_settings_path, notice: "保存成功"
        else
            render_with_alert :index, "保存失败，#{@brokerage.errors.full_messages.first}"
        end
    end


    def brokerage_setting_params
      params.require(:brokerage_setting).permit(permitted_brokerage_setting_attributes)
    end

end
