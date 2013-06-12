class AssignmentsController < InheritedResources::Base
  actions :show

  def show
    show! do
      if user_signed_in?
        @coursework = current_user.courseworks.where("assignment_id = ?", @assignment.id).first
      end
    end
  end

end
