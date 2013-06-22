class CourseworksController < ApplicationController
  inherit_resources
  actions :create, :update

  # TODO /courseworks/<id>/completions
  # def create
  #   @coursework = Coursework.find(params[:coursework_id])
  #   if @coursework.complete

  #   else

  #   end
  # end
  # nest index under users, others do not nest
  def create
    create! do |format|
      @coursework = current_user.courseworks.new(params[:coursework])
      @coursework.completed = false
      if @coursework.save
        format.html { redirect_to(lesson_assignment_path(@coursework.lesson, @coursework.assignment)) }
      else
        format.html { redirect_to(lessons_path, alert: "An error occurred. Please try again later.") }
      end
    end
  end

  def update
    @coursework = current_user.courseworks.where(id: params[:id]).first

    respond_to do |format|
      if @coursework.update_attributes(params[:coursework])
        format.html { redirect_to(lesson_path(@coursework.lesson)) }
      else
        format.html { redirect_to(lessons_path, alert: "An error occurred. Please try again later.") }
      end
    end
  end

end
