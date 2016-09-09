require "rails_helper"

RSpec.describe Admin::SubjectsController, type: :controller do
  let(:admin) {FactoryGirl.create :user, :admin}
  let :attributes_true do
    FactoryGirl.attributes_for :subject, name: "update_name", question_number: 20, duration: 30
  end
  let :attributes_false do
    FactoryGirl.attributes_for :subject, name: nil,
      question_number: 25, duration: 30
  end

  before {sign_in admin}

  context "GET #index" do
    it "render index" do
      get :index
      expect(response).to render_template "index"
    end
  end

  context "GET #new" do
    let(:subject) {Subject.new}
    it "new subject" do
      xhr :get, :new
      expect(subject).to be_a_new Subject
    end
  end

  context "GET #show" do
    let(:subject) {FactoryGirl.create :subject}
    it "render show subject" do
      get :show, id: subject.id
      expect(response).to render_template "show"
    end
  end

  context "POST #create" do
    it "create success" do
      xhr :post, :create, subject: attributes_true
      expect(assigns(:subject)).to be_a Subject
    end

    it "create failed" do
      xhr :post, :create, subject: attributes_false
      expect(assigns(:subject)).to be_a_new Subject
    end
  end

  context "PATCH #update" do
    let!(:subject) {FactoryGirl.create :subject}
    it "update success" do
      xhr :put, :update, id: subject.id, subject: attributes_true
      subject.reload
      expect(subject.name).to eq "update_name"
    end

    it "update failed" do
      xhr :put, :update, id: subject.id, subject: attributes_false
      subject.reload
      expect(subject.name).not_to eq "update_name"
    end
  end

  context "DELETE #destroy" do
    let!(:subject) {FactoryGirl.create :subject}
    it "delete success" do
      expect do
        xhr :delete, :destroy, id: subject.id
      end.to change{Subject.count}.by(-1)
    end

    it "delete failed" do
      subject.destroy
      expect do
        xhr :delete, :destroy, id: subject.id
      end.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
