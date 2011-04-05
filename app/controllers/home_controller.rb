# coding: UTF-8

class HomeController < ApplicationController

  skip_before_filter :browser_is_html5_compliant?, :only => :app_status

  layout 'front_layout'

  def index
    if logged_in?
      redirect_to dashboard_path and return
    else
      @user = User.new
    end
  end

  def app_status
    status = begin
      Rails::Sequel.connection.select('OK').first.values.include?('OK') ? 200 : 500
    rescue Exception => e
      500
    end

    head status
  end

end
