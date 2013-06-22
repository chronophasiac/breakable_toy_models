class LessonsController < ApplicationController
  inherit_resources
  actions :index, :show

  def index
    index! do
      @enrollment = Enrollment.new
    end
  end

  def show
    show! do
      @coursework = Coursework.new
    end
  end

end
