class Admin::QuestionsController < ApplicationController
  before_action :verify_admin
  load_and_authorize_resource

  def index
    @subjects = Subject.all
    @search = Question.contributed.ransack params[:q]
    @statuses = Question.statuses
    @questions =  @search.result.page(params[:page]).per_page(Settings.pagination.per_page)
  end

  def new
    @question.answers.new
    @subjects = Subject.all
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash.now[:success] = t "flash.success.created_question"
      redirect_to admin_subject_path(@question.subject)
    else
      flash.now[:danger] = t "flash.danger.created_question"
      render :new
    end
  end

  def edit
    @subjects = Subject.all
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "flash.danger.edit_question"
      redirect_to admin_questions_path
    else
      flash[:danger] = t "flash.danger.edit_question"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash.now[:success] = t "flash.success.deleted_question"
    else
      @question.destroy
      flash[:danger] = t "flash.danger.deleted_question"
    end
    redirect_to :back
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :answer_type,
      :status, :subject_id, :user_id,
      answers_attributes: [:id, :content, :is_correct, :question_id]
  end
end
