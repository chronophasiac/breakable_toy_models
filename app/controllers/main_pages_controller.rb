class MainPagesController < ApplicationController
  before_filter :authenticate_user!,
    only: [:dashboard]

  def home
    @big_header = true
  end

  def about
  end

  def dashboard
    @dashboard = Dashboard.new(current_user)
  end
end
