class ExamsController < ApplicationController
  def index
    @exam = current_user.exams.new
    @subjects =  Subject.all
    @exams = current_user.exams.page(params[:page])
      .per_page Settings.pagination.per_page
  end

  def create
    @exam = current_user.exams.new exam_params
    if @exam.save
      flash[:success] = t "flash.success.created_exam"
    else
      flash[:danger] = t "flash.danger.created_exam"
    end
    redirect_to root_path
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id
  end
end
