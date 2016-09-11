require "rails_helper"

RSpec.describe "admin/users/show", type: :view do
  let(:admin) {FactoryGirl.create :user, :admin}
  let(:user) {FactoryGirl.create :user}
  before {sign_in admin}

  it "displays user correctly" do
    assign :user, user

    render

    expect(rendered).to include(user.name)
    expect(rendered).to include(user.email)
  end
end
