class AssignmentsController < InheritedResources::Base
  actions :show

  def show
    show! do
      if user_signed_in?
        @lesson = Lesson.where(id: params[:lesson_id]).first
        @coursework = current_user.courseworks.where(assignment_id: @assignment.id).first
      end
    end
  end

end
