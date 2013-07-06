class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @dashboard = Dashboard.new(current_user)
  end
end
