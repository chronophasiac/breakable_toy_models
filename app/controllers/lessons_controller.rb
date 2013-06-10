class LessonsController < InheritedResources::Base
  actions :index, :show

  def index
    index! do
      @enrollment = Enrollment.new
    end
  end

end
