class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!, :load_questions
  def index
  end

  def new
    @question = current_user.questions.new
    @question.answers.new
    @subjects = Subject.all
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash.now[:success] = t "flash.success.created_question"
    else
      flash.now[:danger] = t "flash.danger.created_question"
    end
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :answer_type,
      :status, :subject_id, :user_id,
      answers_attributes: [:id, :content, :is_correct, :question_id]
  end

  def load_questions
    @questions = Question.order("created_at DESC").paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end
end
