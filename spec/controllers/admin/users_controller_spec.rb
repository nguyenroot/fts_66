require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin) {FactoryGirl.create :user, :admin}
  let :attributes_true do
    FactoryGirl.attributes_for :user, name: "update_name"
  end
  let :attributes_false do
    FactoryGirl.attributes_for :subject, name: nil
  end
  before {sign_in admin}

  context "GET #index" do
    it "render index" do
      get :index
      expect(response).to render_template "index"
    end
  end

  context "GET #show" do
    let(:user) {FactoryGirl.create :user}
    it "render show user" do
      get :show, id: user.id
      expect(response).to render_template "show"
    end
  end

  context "GET #edit" do
    let(:user) {FactoryGirl.create :user}
    it "render edit user" do
      get :edit, id: user.id
      expect(response).to render_template "edit"
    end
  end

  context "PATCH #update" do
    let!(:user) {FactoryGirl.create :user}
    it "update success" do
      put :update, id: user.id, user: attributes_true
      user.reload
      expect(user.name).to eq "update_name"
    end

    it "update failed" do
      put :update, id: user.id, user: attributes_false
      user.reload
      expect(user.name).not_to eq "update_name"
    end
  end

  context "DELETE #destroy" do
    let!(:user) {FactoryGirl.create :user}
    it "delete success" do
      expect do
        delete :destroy, id: user.id
      end.to change{User.count}.by(-1)
    end

    it "delete failed" do
      user.destroy
      expect do
        delete :destroy, id: 0
      end.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
