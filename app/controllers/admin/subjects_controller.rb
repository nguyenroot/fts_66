class Admin::SubjectsController < ApplicationController
  before_action :authenticate_user!, :load_subjects
  before_action :load_subject, only: [:edit, :update, :destroy, :show]

  def index
  end

  def show
    @questions = @subject.questions.page(params[:page])
      .per_page Settings.pagination.per_page
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash.now[:success] = t "flash.success.created_subject"
    else
      flash.now[:danger] = t "flash.danger.created_subject"
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash.now[:success] = t "flash.success.updated_subject"
    else
      flash.now[:danger] = t "flash.danger.updated_subject"
    end
  end

  def destroy
    if @subject.present? && @subject.destroy
      flash.now[:success] = t "flash.success.deleted_subject"
    else
      flash.now[:danger] = t "flash.danger.deleted_subject"
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :question_number,
      :duration, :image_path
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    unless @subject
      flash.now[:danger] = t "flash.danger.subject_not_found"
    end
  end

  def load_subjects
    @subjects = Subject.order("created_at DESC").paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end
end
