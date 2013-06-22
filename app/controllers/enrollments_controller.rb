class EnrollmentsController < ApplicationController
  inherit_resources
  actions :create

  def create
    create! do |format|
      @enrollment = current_user.enrollments.new(params[:enrollment])
      @enrollment.last_accessed_at = DateTime.now
      if @enrollment.save
        format.html { redirect_to(lesson_path(@enrollment.lesson)) }
      else
        format.html { redirect_to(lessons_path, alert: "An error occurred. Please try again later.") }
      end
    end
  end

end
