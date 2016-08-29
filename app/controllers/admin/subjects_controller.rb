class Admin::SubjectsController < ApplicationController
  before_action :authenticate_user!, :load_subjects
  def index
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

  private
  def subject_params
    params.require(:subject).permit :name, :question_number, :duration
  end

  def load_subjects
    @subjects = Subject.order("created_at DESC").paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end
end
