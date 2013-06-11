class LessonsController < InheritedResources::Base
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
