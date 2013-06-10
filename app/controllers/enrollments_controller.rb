class EnrollmentsController < InheritedResources::Base
  actions :create

  def create
    create! do |format|
      @enrollment = current_user.enrollments.new(params[:enrollment])
      @enrollment.last_accessed_at = DateTime.now
      if @enrollment.save
        format.html { redirect_to(lesson_path(@enrollment.lesson)) }
      else
        redirect_to(lessons_path, error: "An error occurred. Please try again later.")
      end
    end
  end

end
