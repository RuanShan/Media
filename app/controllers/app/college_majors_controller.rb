module App
  class CollegeMajorsController < BaseController

    layout "app/educations"
    before_action :find_college

    def index
      @college_majors = @college.majors
    end

    def show
      @college_major = CollegeMajor.find_by_id(params[:id])
      unless @college_major.present?
        redirect_to app_college_majors_url, :notice => "数据出错！"
      end
    end

    private

    def find_college
      session[:cid] = params[:cid] if params[:cid].present?

      @college  = College.includes(:majors).find(params[:cid] || session[:cid])
      @college_enroll ||= @college.enrolls.new(user_id: session[:user_id])
    rescue
      return render text: '请求参数不正确'
    end

  end
end

