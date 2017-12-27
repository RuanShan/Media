# -*- coding: utf-8 -*-
class Site::DevLogsController < ApplicationController
  skip_before_action *ADMIN_FILTERS

  layout 'dev_log'

  def index
    start_at = DevLog.vcl.order('created_at desc').first.created_at
    @dev_logs_hash = {}.tap{|h| start_at.year.downto(2013).each {|y| h[y] = DevLog.vcl.order('created_at desc').where("YEAR(created_at) = ?", y).entries }}
  end

  def show
    @dev_log = DevLog.find(params[:id])

    @next_def_log_id = DevLog.vcl.where("id > ?", @dev_log.id).order('id asc').first.try(:id)
    @pre_def_log_id = DevLog.vcl.where("id < ?", @dev_log.id).order('id desc').first.try(:id)
    @list_url = site_dev_logs_url
  end

end
