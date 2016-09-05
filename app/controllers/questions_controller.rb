class QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @questions = current_user.questions
      .page(params[:page]).per_page Settings.pagination.per_page
  end

  def new
    load_all_subject
    @question.answers.new
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash[:success] = t "flash.success.contributed_question"
      redirect_to user_questions_path
    else
      flash[:danger] = t "flash.danger.contributed_question"
      render :new
    end
  end

  def show
  end

  def edit
    load_all_subject
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "flash.success.updated_contributed_question"
      redirect_to user_questions_path
    else
      flash[:danger] = t "flash.danger.updated_contributed_question"
      load_all_subject
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "flash.success.deleted_contributed_question"
    else
      flash[:danger] = t "flash.danger.deleted_contributed_question"
    end
    redirect_to user_questions_path
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :answer_type,
      :subject_id, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_all_subject
    @subjects =  Subject.all
  end
end
