class AssignmentsController < InheritedResources::Base
  actions :show

  def show
    show! do
      if user_signed_in?
        @lesson = Lesson.find(params[:lesson_id])
        @coursework = current_user.courseworks.where("assignment_id = ?", @assignment.id).first
      end
    end
  end

end
