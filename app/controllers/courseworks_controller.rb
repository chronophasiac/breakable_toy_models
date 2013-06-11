class CourseworksController < InheritedResources::Base
  actions :create

  def create
    create! do |format|
      @coursework = current_user.courseworks.new(params[:coursework])
      @coursework.completed = false
      if @coursework.save
        format.html { redirect_to(assignment_path(@coursework.assignment)) }
      else
        format.html { redirect_to(lessons_path, alert: "An error occurred. Please try again later.") }
      end
    end
  end

end
