class Biz::WmallGroupsController < Biz::WmallGroupBaseController

  before_action :set_group, only:[:index]

  def index
    @activity =  @group.activity
  end

  private

  def set_group
    @group = current_site.group
    @group = current_site.create_group unless @group
  end
end
