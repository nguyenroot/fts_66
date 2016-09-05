class ExamsController < ApplicationController
  before_action :load_exam, only: [:show, :update]

  def index
    @exam = current_user.exams.new
    @subjects =  Subject.all
    @exams = current_user.exams.order("updated_at DESC").page(params[:page])
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

  def show
    @exam.update_status
    @exam.exam_questions.each do |exam_question|
      exam_question.build_exam_answers
    end
  end

  def update
    if @exam.update_attributes exam_params
      @exam.update_status params[:finish]
      flash[:success] = t "flash.success.saved_exam"
    else
      flash[:danger] = t "flash.danger.saved_exam"
    end
    redirect_to exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id,
      exam_questions_attributes: [:id, exam_answers_attributes: [:id,
      :answer_id, :content_answer, :_destroy]]
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    unless @exam
      flash[:danger] = I18n.t "flash.danger.exam_not_found"
      redirect_to root_path
    end
  end
end
