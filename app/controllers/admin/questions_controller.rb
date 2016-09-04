class Admin::QuestionsController < ApplicationController
  before_action :verify_admin
  load_and_authorize_resource

  def index
    @questions = @questions.order("created_at DESC").paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end

  def new
    @question = current_user.questions.new
    @question.answers.new
    @subjects = Subject.all
  end

  def create
    load_questions
    @question = current_user.questions.new question_params
    if @question.save
      flash.now[:success] = t "flash.success.created_question"
    else
      flash.now[:danger] = t "flash.danger.created_question"
    end
  end

  def edit
    @subjects = Subject.all
  end

  def update
    load_questions
    if @question.update_attributes question_params
      flash.now[:success] = t "flash.success.updated_question"
    else
      flash.now[:danger] = t "flash.danger.updated_question"
    end
  end

  def destroy
    load_questions
    if @question.nil?
      flash.now[:danger] = t "flash.success.deleted_question"
    else
      @question.destroy
      flash[:success] = t "flash.success.deleted_question"
    end
    redirect_to :back
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :answer_type,
      :status, :subject_id, :user_id,
      answers_attributes: [:id, :content, :is_correct, :question_id]
  end

  def load_question
    @question = Question.find_by id: params[:id]
    unless @question
      flash.now[:danger] = t "flash.danger.question_not_found"
    end
  end

  def load_questions
    @questions = Question.order("created_at DESC")
      .paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end
end
