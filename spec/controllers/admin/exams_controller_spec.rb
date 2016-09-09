require "rails_helper"

RSpec.describe Admin::ExamsController, type: :controller do
  let(:admin) {FactoryGirl.create :user, :admin}
  before {sign_in admin}

  context "GET #index" do
    it "render index" do
      get :index
      expect(response).to render_template "index"
    end
  end

  context "GET #show" do
    let(:subject) {FactoryGirl.create :subject}
    let(:exam) {Exam.create subject_id: subject.id, user_id: admin.id}
    it "render show subject" do
      get :show, id: exam.id
      expect(response).to render_template "show"
    end
  end

  context "PATCH #update" do
    let!(:subject) {FactoryGirl.create :subject}
    it "update success" do
      exam = Exam.create subject_id: subject.id,
        user_id: admin.id, started_at: Time.now
      exam.testing!
      put :update, id: exam.id, exam: {score: 10}
      exam.update_status is_finished_or_checked: true
      exam.reload
      expect(exam.status).to eq "uncheck"
      expect(response).to redirect_to admin_exams_path
    end
  end
end
